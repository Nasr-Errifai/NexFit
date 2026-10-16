import uuid

from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel, Field
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth import CurrentUser
from app.database import get_db
from app.models import Profile, SportsProfile

router = APIRouter(prefix="/me", tags=["me"])


# ---------- Schemas ----------

class ProfileOut(BaseModel):
    id: uuid.UUID
    email: str | None = None
    display_name: str | None = None
    role: str
    locale: str
    avatar_path: str | None = None
    has_sports_profile: bool = False


class ProfileUpdate(BaseModel):
    display_name: str | None = Field(None, max_length=100)
    locale: str | None = Field(None, pattern="^(fr|en)$")
    avatar_path: str | None = None


class SportsProfileIn(BaseModel):
    level: str = Field(pattern="^(beginner|intermediate|advanced)$")
    goal: str = Field(pattern="^(weight_loss|strength|hypertrophy|conditioning)$")
    days_per_week: int = Field(ge=1, le=7)
    session_duration_min: int = Field(ge=10, le=240)
    equipment: list[str] = Field(min_length=1)
    preferences: str | None = Field(None, max_length=1000)
    limitations: str | None = Field(None, max_length=1000)


class SportsProfileOut(SportsProfileIn):
    pass


# ---------- Helpers ----------

async def _ensure_profile(user: dict, db: AsyncSession) -> Profile:
    """Fetch or create the profiles row for an authenticated user (sync from auth)."""
    result = await db.execute(select(Profile).where(Profile.id == user["id"]))
    profile = result.scalar_one_or_none()
    if profile is None:
        profile = Profile(
            id=user["id"],
            display_name=user.get("user_metadata", {}).get("display_name"),
            role="admin" if "admin" in (user.get("app_metadata", {}).get("roles") or []) else "user",
        )
        db.add(profile)
        await db.commit()
        await db.refresh(profile)
    return profile


# ---------- Routes ----------

@router.get("", response_model=ProfileOut)
async def get_me(user: CurrentUser, db: AsyncSession = Depends(get_db)):
    profile = await _ensure_profile(user, db)
    sp = await db.execute(select(SportsProfile).where(SportsProfile.user_id == profile.id))
    has_sp = sp.scalar_one_or_none() is not None
    return ProfileOut(
        id=profile.id,
        email=user.get("email"),
        display_name=profile.display_name,
        role=profile.role,
        locale=profile.locale,
        avatar_path=profile.avatar_path,
        has_sports_profile=has_sp,
    )


@router.patch("", response_model=ProfileOut)
async def update_me(body: ProfileUpdate, user: CurrentUser, db: AsyncSession = Depends(get_db)):
    profile = await _ensure_profile(user, db)
    updates = body.model_dump(exclude_unset=True)
    for k, v in updates.items():
        setattr(profile, k, v)
    await db.commit()
    return await get_me(user, db)


@router.get("/sports-profile", response_model=SportsProfileOut | None)
async def get_sports_profile(user: CurrentUser, db: AsyncSession = Depends(get_db)):
    result = await db.execute(select(SportsProfile).where(SportsProfile.user_id == user["id"]))
    return result.scalar_one_or_none()


@router.put("/sports-profile", response_model=SportsProfileOut)
async def upsert_sports_profile(body: SportsProfileIn, user: CurrentUser, db: AsyncSession = Depends(get_db)):
    await _ensure_profile(user, db)
    result = await db.execute(select(SportsProfile).where(SportsProfile.user_id == user["id"]))
    sp = result.scalar_one_or_none()
    if sp is None:
        sp = SportsProfile(user_id=user["id"], **body.model_dump())
        db.add(sp)
    else:
        for k, v in body.model_dump().items():
            setattr(sp, k, v)
    await db.commit()
    await db.refresh(sp)
    return sp
