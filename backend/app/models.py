import uuid
from datetime import date, datetime
from decimal import Decimal

from sqlalchemy import (
    Boolean,
    Date,
    DateTime,
    ForeignKey,
    Integer,
    Numeric,
    String,
    Text,
    func,
)
from sqlalchemy.dialects.postgresql import ARRAY, JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.types import JSON

from app.database import Base

# Portable JSON type: JSONB on Postgres, JSON elsewhere (tests)
JSONType = JSONB().with_variant(JSON(), "sqlite")
# Portable array type: ARRAY on Postgres, JSON on SQLite (tests)
ArrayType = ARRAY(Text).with_variant(JSON(), "sqlite")


class Profile(Base):
    __tablename__ = "profiles"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True)
    role: Mapped[str] = mapped_column(Text, default="user")
    display_name: Mapped[str | None] = mapped_column(Text)
    avatar_path: Mapped[str | None] = mapped_column(Text)
    locale: Mapped[str] = mapped_column(Text, default="fr")
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    sports_profile: Mapped["SportsProfile | None"] = relationship(back_populates="profile")


class SportsProfile(Base):
    __tablename__ = "sports_profiles"

    user_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="cascade"), primary_key=True)
    level: Mapped[str] = mapped_column(Text)
    goal: Mapped[str] = mapped_column(Text)
    days_per_week: Mapped[int] = mapped_column(Integer)
    session_duration_min: Mapped[int] = mapped_column(Integer)
    equipment: Mapped[list[str]] = mapped_column(ArrayType, default=list)
    preferences: Mapped[str | None] = mapped_column(Text)
    limitations: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    profile: Mapped["Profile"] = relationship(back_populates="sports_profile")


class Exercise(Base):
    __tablename__ = "exercises"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name_fr: Mapped[str] = mapped_column(Text)
    name_en: Mapped[str] = mapped_column(Text, unique=True)
    muscle_group: Mapped[str] = mapped_column(Text)
    movement_type: Mapped[str] = mapped_column(Text)
    equipment: Mapped[str] = mapped_column(Text)
    difficulty: Mapped[str] = mapped_column(Text)
    exercise_type: Mapped[str] = mapped_column(Text)
    instructions_fr: Mapped[list] = mapped_column(JSONType, default=list)
    instructions_en: Mapped[list] = mapped_column(JSONType, default=list)
    common_mistakes_fr: Mapped[str | None] = mapped_column(Text)
    common_mistakes_en: Mapped[str | None] = mapped_column(Text)
    image_path: Mapped[str | None] = mapped_column(Text)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    alternatives: Mapped[list["ExerciseAlternative"]] = relationship(
        back_populates="exercise", foreign_keys="ExerciseAlternative.exercise_id"
    )


class ExerciseAlternative(Base):
    __tablename__ = "exercise_alternatives"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    exercise_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("exercises.id", ondelete="cascade"))
    alternative_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("exercises.id", ondelete="cascade"))
    reason_fr: Mapped[str | None] = mapped_column(Text)
    reason_en: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    exercise: Mapped["Exercise"] = relationship(back_populates="alternatives", foreign_keys=[exercise_id])
    alternative: Mapped["Exercise"] = relationship(foreign_keys=[alternative_id])


class Program(Base):
    __tablename__ = "programs"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    name_fr: Mapped[str] = mapped_column(Text)
    name_en: Mapped[str] = mapped_column(Text)
    description_fr: Mapped[str | None] = mapped_column(Text)
    description_en: Mapped[str | None] = mapped_column(Text)
    split_type: Mapped[str] = mapped_column(Text)
    days_per_week: Mapped[int] = mapped_column(Integer)
    level: Mapped[str] = mapped_column(Text)
    goal: Mapped[str] = mapped_column(Text)
    source: Mapped[str] = mapped_column(Text, default="predefined")
    created_by: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="set null"))
    is_public: Mapped[bool] = mapped_column(Boolean, default=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    days: Mapped[list["ProgramDay"]] = relationship(back_populates="program", order_by="ProgramDay.day_index")


class ProgramDay(Base):
    __tablename__ = "program_days"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    program_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("programs.id", ondelete="cascade"))
    day_index: Mapped[int] = mapped_column(Integer)
    name_fr: Mapped[str] = mapped_column(Text)
    name_en: Mapped[str] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    program: Mapped["Program"] = relationship(back_populates="days")
    exercises: Mapped[list["ProgramExercise"]] = relationship(
        back_populates="day", order_by="ProgramExercise.order_index"
    )


class ProgramExercise(Base):
    __tablename__ = "program_exercises"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    program_day_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("program_days.id", ondelete="cascade"))
    exercise_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("exercises.id", ondelete="cascade"))
    order_index: Mapped[int] = mapped_column(Integer)
    target_sets: Mapped[int] = mapped_column(Integer)
    target_reps: Mapped[str] = mapped_column(Text)
    rest_seconds: Mapped[int] = mapped_column(Integer, default=90)
    notes: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    day: Mapped["ProgramDay"] = relationship(back_populates="exercises")
    exercise: Mapped["Exercise"] = relationship()


class Workout(Base):
    __tablename__ = "workouts"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="cascade"))
    program_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("programs.id", ondelete="set null"))
    program_day_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("program_days.id", ondelete="set null"))
    date: Mapped[date] = mapped_column(Date, default=date.today)
    status: Mapped[str] = mapped_column(Text, default="planned")
    started_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    finished_at: Mapped[datetime | None] = mapped_column(DateTime(timezone=True))
    client_token: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True))
    notes: Mapped[str | None] = mapped_column(Text)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    sets: Mapped[list["WorkoutSet"]] = relationship(back_populates="workout")


class WorkoutSet(Base):
    __tablename__ = "workout_sets"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    workout_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("workouts.id", ondelete="cascade"))
    exercise_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("exercises.id", ondelete="cascade"))
    set_index: Mapped[int] = mapped_column(Integer)
    target_reps: Mapped[int | None] = mapped_column(Integer)
    reps: Mapped[int | None] = mapped_column(Integer)
    weight_kg: Mapped[Decimal | None] = mapped_column(Numeric(6, 2))
    is_warmup: Mapped[bool] = mapped_column(Boolean, default=False)
    completed: Mapped[bool] = mapped_column(Boolean, default=False)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    workout: Mapped["Workout"] = relationship(back_populates="sets")
    exercise: Mapped["Exercise"] = relationship()


class PersonalRecord(Base):
    __tablename__ = "personal_records"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="cascade"))
    exercise_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("exercises.id", ondelete="cascade"))
    record_type: Mapped[str] = mapped_column(Text)
    value: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    workout_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("workouts.id", ondelete="set null"))
    achieved_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())


class Goal(Base):
    __tablename__ = "goals"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="cascade"))
    type: Mapped[str] = mapped_column(Text)
    target: Mapped[Decimal] = mapped_column(Numeric(10, 2))
    current: Mapped[Decimal] = mapped_column(Numeric(10, 2), default=0)
    start_date: Mapped[date] = mapped_column(Date, default=date.today)
    target_date: Mapped[date | None] = mapped_column(Date)
    status: Mapped[str] = mapped_column(Text, default="active")
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())


class RecommendationLog(Base):
    __tablename__ = "recommendation_logs"

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    user_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("profiles.id", ondelete="cascade"))
    input_snapshot: Mapped[dict] = mapped_column(JSONType, default=dict)
    explanation: Mapped[str] = mapped_column(Text)
    accepted: Mapped[bool | None] = mapped_column(Boolean)
    applied_program_id: Mapped[uuid.UUID | None] = mapped_column(UUID(as_uuid=True), ForeignKey("programs.id", ondelete="set null"))
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
