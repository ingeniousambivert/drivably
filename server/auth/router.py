from fastapi import Body, APIRouter
from fastapi.security import HTTPBasicCredentials
from server.database.controllers.user_controller import retrieve_user_by_email
from server.database.helpers.user_helper import safe_user
from .helpers import (validate_user, create_encoded_user,
                      check_user_exists, add_token)

from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema,
)

router = APIRouter()


# SIGNUP user
@router.post("/signup", response_description="user signed up")
async def signup_user(user: UserSchema = Body(...)):
    email_exists = await check_user_exists(user.email)

    if not email_exists:
        encoded_user = await create_encoded_user(user)
        encoded_user = add_token(encoded_user)
        return ResponseModel(safe_user(encoded_user))

    return ErrorResponseModel("Conflict", 409, "Email already exists")


# SIGNIN user
@router.post("/signin", response_description="user signed in")
async def signin_user(credentials:  HTTPBasicCredentials = Body(...)):
    validated = await validate_user(credentials)

    if validated:
        user_data = await retrieve_user_by_email(credentials.username)
        user_data = add_token(user_data)
        return safe_user(user_data)

    return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")
