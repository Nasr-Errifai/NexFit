import uuid

import pytest_asyncio

from app.models import Exercise, Program, ProgramDay, ProgramExercise


@pytest_asyncio.fixture
async def sample_program(db):
    exercise = Exercise(
        id=uuid.uuid4(),
        name_fr="Pompes",
        name_en="Push-up",
        muscle_group="chest",
        movement_type="compound",
        equipment="bodyweight",
        difficulty="beginner",
        exercise_type="bodyweight",
        is_active=True,
    )
    program = Program(
        id=uuid.uuid4(),
        name_fr="Full Body 3 jours",
        name_en="Full Body 3 Days",
        description_fr="Programme complet",
        split_type="full_body",
        days_per_week=3,
        level="beginner",
        goal="hypertrophy",
        source="predefined",
        is_public=True,
    )
    day = ProgramDay(
        id=uuid.uuid4(),
        program_id=program.id,
        day_index=0,
        name_fr="Full Body A",
        name_en="Full Body A",
    )
    db.add_all([exercise, program, day])
    await db.commit()

    pe = ProgramExercise(
        id=uuid.uuid4(),
        program_day_id=day.id,
        exercise_id=exercise.id,
        order_index=0,
        target_sets=3,
        target_reps="10-12",
        rest_seconds=60,
    )
    db.add(pe)
    await db.commit()
    return program


async def test_list_programs(client, sample_program):
    resp = await client.get("/programs")
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["name_en"] == "Full Body 3 Days"


async def test_filter_programs_by_goal(client, sample_program):
    resp = await client.get("/programs", params={"goal": "hypertrophy"})
    assert len(resp.json()) == 1

    resp = await client.get("/programs", params={"goal": "strength"})
    assert len(resp.json()) == 0


async def test_filter_programs_by_level(client, sample_program):
    resp = await client.get("/programs", params={"level": "beginner"})
    assert len(resp.json()) == 1

    resp = await client.get("/programs", params={"level": "advanced"})
    assert len(resp.json()) == 0


async def test_get_program_detail(client, sample_program):
    resp = await client.get(f"/programs/{sample_program.id}")
    assert resp.status_code == 200
    data = resp.json()
    assert data["name_fr"] == "Full Body 3 jours"
    assert len(data["days"]) == 1
    day = data["days"][0]
    assert day["name_en"] == "Full Body A"
    assert len(day["exercises"]) == 1
    pe = day["exercises"][0]
    assert pe["target_sets"] == 3
    assert pe["target_reps"] == "10-12"
    assert pe["exercise"]["name_en"] == "Push-up"


async def test_get_program_not_found(client):
    resp = await client.get(f"/programs/{uuid.uuid4()}")
    assert resp.status_code == 404
