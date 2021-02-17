import time
import jwt
from typing import Dict
from server.utils.config import configured


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
    token = jwt.encode(payload, configured.JWT_SECRET,
                       algorithm=configured.JWT_ALGORITHM)

    return token_response(token)


def decodeJWT(token: str) -> dict:
    try:
        decoded_token = jwt.decode(
            token, configured.JWT_SECRET, algorithms=[configured.JWT_ALGORITHM])
        return decoded_token if decoded_token["expires"] >= time.time() else None
    except:
        return {}
