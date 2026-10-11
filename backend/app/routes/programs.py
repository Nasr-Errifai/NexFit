import uuid

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.database import get_db
from app.models import Program, ProgramDay, ProgramExercise
from app.schemas import ProgramDetail, ProgramListItem

router = APIRouter(prefix="/programs", tags=["programs"])


@router.get("", response_model=list[ProgramListItem])
async def list_programs(
    goal: str | None = Query(None),
    level: str | None = Query(None),
    days_per_week: int | None = Query(None, ge=1, le=7),
    db: AsyncSession = Depends(get_db),
):
    query = select(Program).where(Program.is_public == True)  # noqa: E712
    if goal:
        query = query.where(Program.goal == goal)
    if level:
        query = query.where(Program.level == level)
    if days_per_week:
        query = query.where(Program.days_per_week == days_per_week)
    query = query.order_by(Program.days_per_week, Program.name_en)
    result = await db.execute(query)
    return result.scalars().all()


@router.get("/{program_id}", response_model=ProgramDetail)
async def get_program(program_id: uuid.UUID, db: AsyncSession = Depends(get_db)):
    query = (
        select(Program)
        .options(
            selectinload(Program.days)
            .selectinload(ProgramDay.exercises)
            .selectinload(ProgramExercise.exercise)
        )
        .where(Program.id == program_id, Program.is_public == True)  # noqa: E712
    )
    result = await db.execute(query)
    program = result.scalar_one_or_none()
    if not program:
        raise HTTPException(status_code=404, detail="Program not found")
    return program
