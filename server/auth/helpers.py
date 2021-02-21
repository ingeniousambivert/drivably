from fastapi import Depends
from passlib.hash import bcrypt
from .jwt.handler import signJWT
from fastapi.security import HTTPBasicCredentials, HTTPBasic
from fastapi.encoders import jsonable_encoder
from server.database.helpers.user_helper import users_collection
from server.database.controllers.user_controller import add_user

security = HTTPBasic()


async def create_encoded_user(user):
    user.password = bcrypt.hash(user.password)
    user = jsonable_encoder(user)
    return await add_user(user)


def add_token(user):
    user_token = signJWT(user["email"])
    user["access_token"] = user_token["access_token"]
    return user


def verify_password(password: str, password_hash: str):
    if bcrypt.verify(password, password_hash):
        return True
    return False


async def validate_user(credentials: HTTPBasicCredentials = Depends(security)):
    user = await users_collection.find_one({"email": credentials.username}, {"_id": 0})
    if not user:
        return False
    if not verify_password(credentials.password, user["password"]):
        return False
    return True


async def check_user_exists(email: str):
    user = await users_collection.find_one({"email": email}, {"_id": 0})
    if user:
        return True
    return False
