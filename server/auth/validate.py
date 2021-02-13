from passlib.hash import bcrypt
from server.database.helpers.user_helper import users_collection


async def validate_user(username: str, password: str):
    user = await users_collection.find_one({"email": username}, {"_id": 0})
    if not user:
        return False
    if not bcrypt.verify(password, user["password"]):
        return False
    return True
