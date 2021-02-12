from fastapi import Body, APIRouter
from fastapi.encoders import jsonable_encoder
from fastapi.security import HTTPBasicCredentials
from passlib.context import CryptContext
#from server.auth.validate import validate_login
from server.auth.jwt_handler import signJWT


from fastapi.security import HTTPBasicCredentials
from passlib.context import CryptContext

from server.database.helpers.user_helper import users_collection
from server.database.controllers.user_controller import add_user

from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema,
)

router = APIRouter()
hash_helper = CryptContext(schemes=["bcrypt"])

# SIGNUP user


@router.post("/signup", response_description="user signed up")
async def signup_user(user: UserSchema = Body(...)):

    user_email = users_collection.find_one({"email":  user.email})
    if(user_email):
        return ErrorResponseModel("Conflict", 409, "Email already exists")

    user.password = hash_helper.encrypt(user.password)
    user = jsonable_encoder(user)
    new_user = await add_user(user)
    return ResponseModel(new_user, "user added successfully.")


# SIGNIN user
@router.post("/signin", response_description="user signed in")
async def signin_user(user_credentials: HTTPBasicCredentials = Body(...)):
    user = await users_collection.find_one({"email": user_credentials.username}, {"_id": 0})
    if (user):
        password = hash_helper.verify(
            user_credentials.password, user["password"])
        if (password):
            return signJWT(user_credentials.username)

        return ErrorResponseModel("NotAuthenticated", 401, "Incorrect email or password")
