import time
import jwt
from fastapi import Depends
from typing import Dict
from fastapi.security import OAuth2PasswordBearer
from core.config import JWT_SECRET, JWT_ALGORITHM

oauth2_scheme = OAuth2PasswordBearer(tokenUrl='signin')


def token_response(token: str):
    return {
        "access_token": token,
        "token_type": "bearer"
    }


def signJWT(username: str) -> Dict[str, str]:
    payload = {
        "username": username,
        "expires": time.time() + 2400
    }
    token = jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGORITHM)

    return token_response(token)


def decodeJWT(token: str = Depends(oauth2_scheme)) -> dict:
    try:
        decoded_token = jwt.decode(
            token, JWT_SECRET, algorithms=[JWT_ALGORITHM])
        return decoded_token if decoded_token["expires"] >= time.time() else None
    except:
        return {}
