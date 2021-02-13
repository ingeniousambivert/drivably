from server.database.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UpdateUserModel,
)
from server.database.controllers.user_controller import (
    delete_user,
    retrieve_user,
    retrieve_users,
    update_user,
)
from fastapi import Body, APIRouter


router = APIRouter()


# GET all users
@router.get("/", response_description="Users retrieved")
async def get_all_users_data():
    users = await retrieve_users()
    if users:
        return ResponseModel(users, "Users data retrieved successfully")
    return ResponseModel(users, "Empty list returned")


# GET a user
@router.get("/{id}", response_description="User data retrieved")
async def get_user_data(id):
    user = await retrieve_user(id)
    if user:
        return ResponseModel(user, "User data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "User doesn't exist.")


# UPDATE a user
@router.put("/{id}", response_description="User data updated")
async def update_user_data(id: str, data: UpdateUserModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_user = await update_user(id, data)
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
@ router.delete("/{id}", response_description="User data deleted from the database")
async def delete_user_data(id: str):
    deleted_user = await delete_user(id)
    if deleted_user:
        return ResponseModel(
            "User with ID: {} removed".format(id), "user deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "User with id {0} doesn't exist".format(id)
    )
