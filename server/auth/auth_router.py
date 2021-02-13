from fastapi import Body, APIRouter, Depends
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from .utils import validate_user, create_encoded_user, check_user_exists
from .jwt_handler import signJWT

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
    email_exists = await check_user_exists(user.email)

    if not email_exists:
        encoded_user = await create_encoded_user(user)
        return ResponseModel(encoded_user, "user added successfully.")

    return ErrorResponseModel("Conflict", 409, "Email already exists")


# SIGNIN user
@router.post("/signin", response_description="user signed in")
async def signin_user(credentials: OAuth2PasswordRequestForm = Depends()):
    validated = await validate_user(credentials.username, credentials.password)

    if validated:
        return signJWT(credentials.username)

    return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")