from fastapi.encoders import jsonable_encoder
from passlib.hash import bcrypt
from server.database.helpers.user_helper import users_collection
from server.database.controllers.user_controller import add_user


async def create_encoded_user(user):
    user.password = bcrypt.hash(user.password)
    user = jsonable_encoder(user)
    return await add_user(user)


async def validate_user(username: str, password: str):
    user = await users_collection.find_one({"email": username}, {"_id": 0})
    if not user:
        return False
    if not bcrypt.verify(password, user["password"]):
        return False
    return True


async def check_user_exists(email):
    user = await users_collection.find_one({"email": email}, {"_id": 0})
    if user:
        return True
    return False
