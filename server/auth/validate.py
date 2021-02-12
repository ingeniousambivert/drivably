from fastapi import Depends
from fastapi.security import HTTPBasicCredentials, HTTPBasic
from passlib.context import CryptContext
from server.auth.jwt_handler import signJWT
from server.database.helpers.user_helper import users_collection
from server.database.models.user_model import ErrorResponseModel


security = HTTPBasic()
hash_helper = CryptContext(schemes=["bcrypt"])


async def validate_login(user_credentials: HTTPBasicCredentials = Depends(security)):
    user = await users_collection.find_one({"email": user_credentials.username}, {"_id": 0})
    if (user):
        password = hash_helper.verify(
            user_credentials.password, user["password"])
        if (password):
            return signJWT(user_credentials.username)

    return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")
