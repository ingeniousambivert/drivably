from fastapi import Body, APIRouter, Depends
from fastapi.encoders import jsonable_encoder
from passlib.hash import bcrypt
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from .validate import validate_user
from .jwt_handler import signJWT
from server.database.helpers.user_helper import users_collection
from server.database.controllers.user_controller import add_user

from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema,
)

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl='signin')


# SIGNUP user
@router.post("/signup", response_description="user signed up")
async def signup_user(user: UserSchema = Body(...)):

    user_email = users_collection.find_one({"email":  user.email})
    if(user_email):
        return ErrorResponseModel("Conflict", 409, "Email already exists")

    user.password = bcrypt.hash(user.password)
    user = jsonable_encoder(user)
    new_user = await add_user(user)
    return ResponseModel(new_user, "user added successfully.")


# SIGNIN user
@router.post("/signin", response_description="user signed in")
async def signin_user(credentials: OAuth2PasswordRequestForm = Depends()):
    validated = await validate_user(credentials.username, credentials.password)

    if not validated:
        return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")

    return signJWT(credentials.username)
