import uuid
from typing import Annotated

import httpx
from fastapi import Depends, HTTPException, status
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from jose import JWTError, jwk, jwt

from app.config import settings

bearer_scheme = HTTPBearer(auto_error=False)

_jwks_cache: dict | None = None


async def _get_jwks() -> dict:
    global _jwks_cache
    if _jwks_cache is None:
        async with httpx.AsyncClient(timeout=10) as client:
            resp = await client.get(f"{settings.SUPABASE_URL}/auth/v1/.well-known/jwks.json")
            resp.raise_for_status()
            _jwks_cache = resp.json()
    return _jwks_cache


def _verify(token: str) -> dict:
    """Verify a Supabase access token against the project JWKS (ES256)."""
    try:
        headers = jwt.get_unverified_header(token)
    except JWTError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=f"Invalid token: {e}")

    kid = headers.get("kid")
    jwks = _jwks_cache or {}
    key_data = None
    for k in jwks.get("keys", []):
        if k.get("kid") == kid:
            key_data = k
            break
    if key_data is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Unknown signing key")

    key = jwk.construct(key_data)
    try:
        return jwt.decode(token, key, algorithms=["ES256"], audience="authenticated")
    except JWTError as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail=f"Token rejected: {e}")


async def get_current_user(
    credentials: Annotated[HTTPAuthorizationCredentials | None, Depends(bearer_scheme)],
) -> dict:
    if credentials is None:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Not authenticated")

    # Refresh the JWKS cache if verification fails on kid (key rotation)
    await _get_jwks()
    try:
        claims = _verify(credentials.credentials)
    except HTTPException:
        global _jwks_cache
        _jwks_cache = None
        await _get_jwks()
        claims = _verify(credentials.credentials)

    sub = claims.get("sub")
    if not sub:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="No subject in token")
    try:
        user_id = uuid.UUID(sub)
    except ValueError:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid subject")

    return {
        "id": user_id,
        "email": claims.get("email"),
        "role": claims.get("role"),
        "user_metadata": claims.get("user_metadata") or {},
        "app_metadata": claims.get("app_metadata") or {},
    }


CurrentUser = Annotated[dict, Depends(get_current_user)]
