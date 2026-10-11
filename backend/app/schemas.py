import uuid
from datetime import date, datetime
from decimal import Decimal

from pydantic import BaseModel, ConfigDict


class ORMModel(BaseModel):
    model_config = ConfigDict(from_attributes=True)


# ---------- Exercises ----------

class ExerciseBase(BaseModel):
    name_fr: str
    name_en: str
    muscle_group: str
    movement_type: str
    equipment: str
    difficulty: str
    exercise_type: str


class ExerciseOut(ExerciseBase):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    instructions_fr: list
    instructions_en: list
    common_mistakes_fr: str | None = None
    common_mistakes_en: str | None = None
    image_path: str | None = None
    is_active: bool


class ExerciseListItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    name_fr: str
    name_en: str
    muscle_group: str
    equipment: str
    difficulty: str
    exercise_type: str


class AlternativeOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    alternative: ExerciseListItem
    reason_fr: str | None = None
    reason_en: str | None = None


class ExerciseDetail(ExerciseOut):
    alternatives: list[AlternativeOut] = []


# ---------- Programs ----------

class ProgramExerciseOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    order_index: int
    target_sets: int
    target_reps: str
    rest_seconds: int
    notes: str | None = None
    exercise: ExerciseListItem


class ProgramDayOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    day_index: int
    name_fr: str
    name_en: str
    exercises: list[ProgramExerciseOut] = []


class ProgramListItem(BaseModel):
    model_config = ConfigDict(from_attributes=True)
    id: uuid.UUID
    name_fr: str
    name_en: str
    description_fr: str | None = None
    description_en: str | None = None
    split_type: str
    days_per_week: int
    level: str
    goal: str
    source: str
    is_public: bool


class ProgramDetail(ProgramListItem):
    days: list[ProgramDayOut] = []
