import uuid

from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.database import get_db
from app.models import Exercise, ExerciseAlternative
from app.schemas import ExerciseDetail, ExerciseListItem, ExerciseOut

router = APIRouter(prefix="/exercises", tags=["exercises"])


@router.get("", response_model=list[ExerciseListItem])
async def list_exercises(
    muscle_group: str | None = Query(None),
    equipment: str | None = Query(None),
    difficulty: str | None = Query(None),
    exercise_type: str | None = Query(None),
    search: str | None = Query(None),
    db: AsyncSession = Depends(get_db),
):
    query = select(Exercise).where(Exercise.is_active == True)  # noqa: E712
    if muscle_group:
        query = query.where(Exercise.muscle_group == muscle_group)
    if equipment:
        query = query.where(Exercise.equipment == equipment)
    if difficulty:
        query = query.where(Exercise.difficulty == difficulty)
    if exercise_type:
        query = query.where(Exercise.exercise_type == exercise_type)
    if search:
        pattern = f"%{search}%"
        query = query.where(
            (Exercise.name_fr.ilike(pattern)) | (Exercise.name_en.ilike(pattern))
        )
    query = query.order_by(Exercise.muscle_group, Exercise.name_en)
    result = await db.execute(query)
    return result.scalars().all()


@router.get("/{exercise_id}", response_model=ExerciseDetail)
async def get_exercise(exercise_id: uuid.UUID, db: AsyncSession = Depends(get_db)):
    query = (
        select(Exercise)
        .options(selectinload(Exercise.alternatives).selectinload(ExerciseAlternative.alternative))
        .where(Exercise.id == exercise_id, Exercise.is_active == True)  # noqa: E712
    )
    result = await db.execute(query)
    exercise = result.scalar_one_or_none()
    if not exercise:
        raise HTTPException(status_code=404, detail="Exercise not found")
    return exercise
