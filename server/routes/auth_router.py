from fastapi import Body, APIRouter
from fastapi.encoders import jsonable_encoder
from fastapi.security import HTTPBasicCredentials
from passlib.context import CryptContext
from server.auth.validate import validate_login
from server.auth.jwt_handler import signJWT


from server.database.controllers.user_controller import add_user

from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema,
)

router = APIRouter()

hash_helper = CryptContext(schemes=["bcrypt"])


# SIGNUP a user
@router.post("/signup", response_description="user signed up")
async def signup_user(user: UserSchema = Body(...)):
    # TODO: Perform validation to check if user exists.
    # hash user password before saving to database
    user.password = hash_helper.encrypt(user.password)
    user = jsonable_encoder(user)
    new_user = await add_user(user)
    return ResponseModel(new_user, "user added successfully.")


# SIGNIN a user
@router.post("/signin", response_description="user signed in")
async def signin_user(user: HTTPBasicCredentials = Body(...)):
    if validate_login(user):
        return {
            "email": user.username,
            "access_token": signJWT(user.username)
        }
    return ErrorResponseModel("Incorrect email or password")
