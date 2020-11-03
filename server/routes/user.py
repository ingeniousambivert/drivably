from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder

from server.database import (
    add_user,
    delete_user,
    retrieve_user,
    retrieve_users,
    update_user,
)
from server.models.user import (
    ErrorResponseModel,
    ResponseModel,
    UserSchema,
    UpdateUserModel,
)

router = APIRouter()

# user routes

# GET /users
@router.get("/", response_description="Users retrieved")
async def get_users():
    users = await retrieve_users()
    if users:
        return ResponseModel(users, "Users data retrieved successfully")
    return ResponseModel(users, "Empty list returned")


# GET /users/id
@router.get("/{id}", response_description="User data retrieved")
async def get_user_data(id):
    user = await retrieve_user(id)
    if user:
        return ResponseModel(user, "User data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "User doesn't exist.")


# POST /users
@router.post("/", response_description="user data added into the database")
async def add_user_data(user: UserSchema = Body(...)):
    user = jsonable_encoder(user)
    new_user = await add_user(user)
    return ResponseModel(new_user, "user added successfully.")


# PUT /users/id
@router.put("/{id}")
async def update_user_data(id: str, req: UpdateUserModel = Body(...)):
    req = {key: value for key, value in req.dict().items() if value is not None}
    updated_user = await update_user(id, req)
    if updated_user:
        return ResponseModel(
            "User with ID: {} updated successfully".format(id),
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the user data.",
    )


# DELETE /users/id
@router.delete("/{id}", response_description="User data deleted from the database")
async def delete_user_data(id: str):
    deleted_user = await delete_user(id)
    if deleted_user:
        return ResponseModel(
            "User with ID: {} removed".format(id), "user deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "User with id {0} doesn't exist".format(id)
    )