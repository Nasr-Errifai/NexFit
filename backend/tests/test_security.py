import pathlib
import uuid

from app.auth import get_current_user
from app.main import app

FAKE_USER_ID = uuid.UUID("11111111-1111-4111-8111-111111111111")

# Correctif SQL (relatif à backend/). Vérifié textuellement car les tests
# roulent sur SQLite, qui n'exécute pas les triggers plpgsql.
_MIGRATION = (
    pathlib.Path(__file__).resolve().parents[2]
    / "supabase"
    / "migrations"
    / "0004_prevent_role_escalation.sql"
)


async def test_me_cannot_change_role(client):
    """Un utilisateur authentifié ne peut pas élever son rôle via /me."""

    async def override_user():
        return {
            "id": FAKE_USER_ID,
            "email": "sec@nexfit.ma",
            "role": "authenticated",
            "user_metadata": {},
            "app_metadata": {},
        }

    app.dependency_overrides[get_current_user] = override_user
    try:
        # un champ "role" dans le payload ne doit pas avoir d'effet
        resp = await client.patch("/me", json={"display_name": "X", "role": "admin"})
        assert resp.status_code == 200
        assert resp.json()["role"] == "user"  # reste user
    finally:
        app.dependency_overrides.pop(get_current_user, None)


def test_role_escalation_migration_exists_and_blocks():
    """La migration 0004 existe et bloque l'élévation côté DB (INSERT + UPDATE)."""
    assert _MIGRATION.exists(), f"migration manquante : {_MIGRATION}"
    sql = _MIGRATION.read_text(encoding="utf-8")
    # couche INSERT : force role='user' pour un jeton utilisateur
    assert "new.role := 'user'" in sql
    # couche UPDATE : refuse tout changement de rôle
    assert "role cannot be modified by end users" in sql
    # les deux triggers doivent être posés
    assert "trg_prevent_role_escalation_insert" in sql
    assert "trg_prevent_role_escalation_update" in sql
