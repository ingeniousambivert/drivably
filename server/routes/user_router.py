from fastapi import Body, APIRouter

from server.database.controllers.user_controller import (
    delete_user,
    retrieve_user,
    retrieve_users,
    update_user,
)
from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UpdateUserModel,
)

router = APIRouter()


# GET all users
@router.get("/", response_description="Users retrieved")
async def get_all_users():
    users = await retrieve_users()
    if users:
        return ResponseModel(users, "Users data retrieved successfully")
    return ResponseModel(users, "Empty list returned")


# GET a user
@router.get("/{id}", response_description="User data retrieved")
async def get_user(id):
    user = await retrieve_user(id)
    if user:
        return ResponseModel(user, "User data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "User doesn't exist.")


# UPDATE a user
@router.put("/{id}")
async def update_user(id: str, req: UpdateUserModel = Body(...)):
    req = {key: value for key, value in req.dict().items() if value is not None}
    updated_user = await update_user(id, req)
    if updated_user:
        return ResponseModel(
            "User with ID: {} updated successfully".format(id),
            "User updated successfully",
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the user data.",
    )


# DELETE a user
@router.delete("/{id}", response_description="User data deleted from the database")
async def delete_user(id: str):
    deleted_user = await delete_user(id)
    if deleted_user:
        return ResponseModel(
            "User with ID: {} removed".format(id), "user deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "User with id {0} doesn't exist".format(id)
    )
