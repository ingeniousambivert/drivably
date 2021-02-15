from fastapi import Body, APIRouter
from fastapi.security import HTTPBasicCredentials
from server.database.controllers.user_controller import retrieve_user_by_email
from .helpers import (
    validate_user, create_encoded_user,
    check_user_exists, add_token
)

from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema
)

router = APIRouter()


# SIGNUP user
@router.post("/signup", response_description="user signed up")
async def signup_user(user: UserSchema = Body(...)):
    email_exists = await check_user_exists(user.email)
    encoded_user = dict()

    if not email_exists:
        encoded_user = await create_encoded_user(user)
        encoded_user_with_token = add_token(encoded_user)
        return ResponseModel(encoded_user_with_token)
    elif email_exists:
        return ErrorResponseModel("Conflict", 409, "Email already exists")

    return ErrorResponseModel("Server Error", 500, "Could not signup user")


# SIGNIN user
@router.post("/signin", response_description="user signed in")
async def signin_user(credentials:  HTTPBasicCredentials = Body(...)):
    validated = await validate_user(credentials)

    if validated:
        user_data = await retrieve_user_by_email(credentials.username)
        user_with_token = add_token(user_data)
        return ResponseModel(user_with_token)

    elif not validated:
        return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")

    return ErrorResponseModel("Server Error", 500, "Could not signup user")
