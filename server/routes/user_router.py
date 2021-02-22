from server.services.users.models.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UpdateUserModel,
)
from database.users.user_controller import (
    delete_user,
    retrieve_user,
    retrieve_users,
    update_user,
    retrieve_car_data,
)
from fastapi import Body, APIRouter, File, UploadFile
from server.utils.helpers import (save_upload_file, KNOWN_DATASET_PATH)


router = APIRouter()


# GET all users
@router.get("/", response_description="Users retrieved",)
async def get_all_users_data():
    users = await retrieve_users()
    if users:
        return ResponseModel(users)
    return ResponseModel("Empty list returned")


# GET a user
@router.get("/{id}", response_description="User data retrieved")
async def get_user_data(id):
    user = await retrieve_user(id)
    if user:
        return ResponseModel(user)
    return ErrorResponseModel("An error occurred.", 404, "User doesn't exist.")


# UPDATE a user
@router.put("/{id}", response_description="User data updated")
async def update_user_data(id: str, data: UpdateUserModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_user = await update_user(id, data)
    if updated_user:
        return ResponseModel(
            "User with ID: {} updated successfully".format(id)
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the user data.",
    )


# UPDATE a user's facial data
@router.put("/face/{id}", response_description="User facial data updated")
async def update_user_facial_data(id: str, image: UploadFile = File(...)):
    user_data = await retrieve_user(id)
    safe_file_name = "user_{}_Face.png".format(id)
    safe_dir_name = "user_{}".format(id)
    known_dataset_path = f"{KNOWN_DATASET_PATH}{safe_dir_name}/"
    facial_data = save_upload_file(image, safe_file_name, known_dataset_path)

    if facial_data is not None:
        user_data["facial_data"] = facial_data
        user_data.pop("id")  # prevent data duplication
        updated_user = await update_user(id, user_data)

    if updated_user:
        return ResponseModel(
            "Facial Data for User with ID: {} updated successfully".format(id)
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
            "User with ID: {} deleted successfully".format(id),
        )
    return ErrorResponseModel(
        "An error occurred", 404, "User with id {0} doesn't exist".format(id)
    )


@router.get("/owner/car", response_description="owner's car data retrieved")
async def get_owner_car_data(email: str):
    car_data = await retrieve_car_data(email)
    if car_data:
        return ResponseModel(car_data)
    return ResponseModel("Empty list returned")
