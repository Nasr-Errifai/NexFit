import uuid

import pytest_asyncio

from app.models import Exercise


@pytest_asyncio.fixture
async def sample_exercise(db):
    ex = Exercise(
        id=uuid.uuid4(),
        name_fr="Squat barre",
        name_en="Back Squat",
        muscle_group="legs",
        movement_type="compound",
        equipment="barbell",
        difficulty="intermediate",
        exercise_type="free_weights",
        instructions_fr=["Pieds largeur épaules", "Descends parallèle"],
        instructions_en=["Feet shoulder width", "Descend to parallel"],
        is_active=True,
    )
    db.add(ex)
    await db.commit()
    return ex


async def test_list_exercises_empty(client):
    resp = await client.get("/exercises")
    assert resp.status_code == 200
    assert resp.json() == []


async def test_list_exercises_with_data(client, sample_exercise):
    resp = await client.get("/exercises")
    assert resp.status_code == 200
    data = resp.json()
    assert len(data) == 1
    assert data[0]["name_en"] == "Back Squat"


async def test_filter_by_muscle_group(client, sample_exercise):
    resp = await client.get("/exercises", params={"muscle_group": "legs"})
    assert resp.status_code == 200
    assert len(resp.json()) == 1

    resp = await client.get("/exercises", params={"muscle_group": "chest"})
    assert resp.status_code == 200
    assert len(resp.json()) == 0


async def test_filter_by_equipment(client, sample_exercise):
    resp = await client.get("/exercises", params={"equipment": "barbell"})
    assert len(resp.json()) == 1

    resp = await client.get("/exercises", params={"equipment": "cable"})
    assert len(resp.json()) == 0


async def test_search_exercise(client, sample_exercise):
    resp = await client.get("/exercises", params={"search": "squat"})
    assert len(resp.json()) == 1

    resp = await client.get("/exercises", params={"search": "bench"})
    assert len(resp.json()) == 0


async def test_get_exercise_detail(client, sample_exercise):
    resp = await client.get(f"/exercises/{sample_exercise.id}")
    assert resp.status_code == 200
    data = resp.json()
    assert data["name_fr"] == "Squat barre"
    assert data["instructions_fr"] == ["Pieds largeur épaules", "Descends parallèle"]
    assert data["alternatives"] == []


async def test_get_exercise_not_found(client):
    resp = await client.get(f"/exercises/{uuid.uuid4()}")
    assert resp.status_code == 404
