import uuid

import pytest_asyncio

from app.auth import get_current_user

FAKE_USER_ID = uuid.UUID("11111111-1111-4111-8111-111111111111")


@pytest_asyncio.fixture
async def auth_client(client):
    async def override_user():
        return {
            "id": FAKE_USER_ID,
            "email": "test@nexfit.ma",
            "role": "authenticated",
            "user_metadata": {"display_name": "Test User"},
            "app_metadata": {},
        }

    from app.main import app

    app.dependency_overrides[get_current_user] = override_user
    yield client
    app.dependency_overrides.pop(get_current_user, None)


async def test_me_unauthenticated(client):
    resp = await client.get("/me")
    assert resp.status_code == 401


async def test_me_creates_profile(auth_client):
    resp = await auth_client.get("/me")
    assert resp.status_code == 200
    data = resp.json()
    assert data["id"] == str(FAKE_USER_ID)
    assert data["email"] == "test@nexfit.ma"
    assert data["role"] == "user"
    assert data["has_sports_profile"] is False

    # second call reuses the same profile
    resp2 = await auth_client.get("/me")
    assert resp2.json()["id"] == str(FAKE_USER_ID)


async def test_me_update_profile(auth_client):
    resp = await auth_client.patch("/me", json={"display_name": "Yassine", "locale": "en"})
    assert resp.status_code == 200
    data = resp.json()
    assert data["display_name"] == "Yassine"
    assert data["locale"] == "en"


async def test_me_update_invalid_locale(auth_client):
    resp = await auth_client.patch("/me", json={"locale": "de"})
    assert resp.status_code == 422


async def test_sports_profile_empty(auth_client):
    resp = await auth_client.get("/me/sports-profile")
    assert resp.status_code == 200
    assert resp.json() is None


async def test_sports_profile_upsert(auth_client):
    payload = {
        "level": "beginner",
        "goal": "hypertrophy",
        "days_per_week": 3,
        "session_duration_min": 60,
        "equipment": ["barbell", "dumbbell"],
    }
    resp = await auth_client.put("/me/sports-profile", json=payload)
    assert resp.status_code == 200
    data = resp.json()
    assert data["level"] == "beginner"
    assert data["equipment"] == ["barbell", "dumbbell"]

    # has_sports_profile flag now true
    me = (await auth_client.get("/me")).json()
    assert me["has_sports_profile"] is True

    # update (not duplicate)
    payload["level"] = "advanced"
    payload["days_per_week"] = 5
    resp = await auth_client.put("/me/sports-profile", json=payload)
    assert resp.status_code == 200
    assert resp.json()["level"] == "advanced"

    sp = (await auth_client.get("/me/sports-profile")).json()
    assert sp["days_per_week"] == 5


async def test_sports_profile_validation(auth_client):
    resp = await auth_client.put(
        "/me/sports-profile",
        json={
            "level": "expert",
            "goal": "hypertrophy",
            "days_per_week": 3,
            "session_duration_min": 60,
            "equipment": ["barbell"],
        },
    )
    assert resp.status_code == 422

    resp = await auth_client.put(
        "/me/sports-profile",
        json={
            "level": "beginner",
            "goal": "hypertrophy",
            "days_per_week": 0,
            "session_duration_min": 60,
            "equipment": ["barbell"],
        },
    )
    assert resp.status_code == 422
