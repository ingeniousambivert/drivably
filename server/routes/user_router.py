from fastapi import status, BackgroundTasks
from server.services.users.model.user_model import (
    ErrorResponseModel,
    ResponseModel,
    UpdateUserModel,
)
from database.users.user_controller import (
    delete_user,
    retrieve_user,
    delete_car,
    add_car_driver,
    retrieve_users,
    update_user,
    retrieve_car_data,
)
from fastapi import Body, APIRouter, File, UploadFile
from server.utils.helpers import (
    save_upload_file, KNOWN_DATASET_PATH, remove_file)
from intelligence.facial_recognition.helpers import detect_face
from intelligence.drowsiness_detection.detect_live import detect_drowsiness

router = APIRouter()


# GET all users
@router.get("/", response_description="Users retrieved")
async def get_all_users_data():
    users = await retrieve_users()
    if users:
        return ResponseModel(users, status.HTTP_200_OK, "Successfully retrieved users")
    return ErrorResponseModel("An error occurred.", status.HTTP_404_NOT_FOUND, "Users don't exist.")


# GET a user
@router.get("/{email}", response_description="User data retrieved")
async def get_user_data(email):
    user = await retrieve_user(email)
    if user:
        return ResponseModel(user, status.HTTP_200_OK, "Successfully retrieved user")
    return ErrorResponseModel("An error occurred.", status.HTTP_404_NOT_FOUND, "User doesn't exist.")


# UPDATE a user
@router.put("/{email}", response_description="User data updated")
async def update_user_data(email: str, data: UpdateUserModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_user = await update_user(email, data)
    if updated_user:
        return ResponseModel("Updated", status.HTTP_200_OK,
                             "Successfully updated user with email: " + email
                             )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_400_BAD_REQUEST,
        "There was an error updating the user data.",
    )


# UPDATE a user's car
@router.put("/car/{email}", response_description="User's car data updated")
async def update_user_car(email: str, license_number: str):
    updated_user = await add_car_driver(email, license_number)
    if updated_user:
        return ResponseModel(
            "Updated", status.HTTP_200_OK, "Successfully updated car: " +
            license_number + " for user with email : " + email
        )
    return ErrorResponseModel(
        "An error occurred", status.HTTP_404_NOT_FOUND, "User with email {} doesn't exist".format(
            email)
    )


# UPDATE a user's facial data
@router.put("/face/{email}", response_description="User facial data updated")
async def update_user_facial_data(email: str, image: UploadFile = File(...)):

    user_data = await retrieve_user(email)
    safe_file_name = "user_{}_Face.png".format(email)
    safe_dir_name = "user_{}".format(email)
    known_dataset_path = f"{KNOWN_DATASET_PATH}{safe_dir_name}/"

    facial_data = save_upload_file(
        image, safe_file_name, known_dataset_path)

    if not detect_face(facial_data["file_location"]):
        remove_file(facial_data["file_location"])
        return ErrorResponseModel("Face Not Found", status.HTTP_400_BAD_REQUEST, "Could not find a face in the uploaded image")

    if facial_data:
        user_data["facial_data"] = facial_data["dir_location"]
        user_data.pop("email")  # prevent data duplication
        updated_user = await update_user(email, user_data)

    if updated_user:
        return ResponseModel(
            "Updated", status.HTTP_200_OK, "Successfully updated user's facial data with email:" + email
        )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_400_BAD_REQUEST,
        "There was an error updating the user data.",
    )


# DELETE a user
@ router.delete("/{email}", response_description="User data deleted from the database")
async def delete_user_data(email: str):
    deleted_user = await delete_user(email)
    if deleted_user:
        return ResponseModel(
            "Deleted", status.HTTP_200_OK, "Successfully deleted user with email: " + email
        )
    return ErrorResponseModel(
        "An error occurred", status.HTTP_404_NOT_FOUND, "User with email {} doesn't exist".format(
            email)
    )


# DELETE a user
@ router.delete("/car/{email}", response_description="Car data deleted from the user")
async def delete_user_car(email: str, license_number: str):
    deleted_car = await delete_car(email, license_number)
    if deleted_car:
        return ResponseModel(
            "Deleted", status.HTTP_200_OK, "Successfully deleted car: " +
            license_number + " for user with email : " + email
        )
    return ErrorResponseModel(
        "An error occurred", status.HTTP_404_NOT_FOUND, "Car with email {} doesn't exist".format(
            license_number)
    )


# GET user's car
@router.get("/car/", response_description="user's car data retrieved")
async def get_user_car(email: str):
    car_data = await retrieve_car_data(email)
    if car_data:
        return ResponseModel(car_data, status.HTTP_200_OK, "Successfully retrieved user's car data")
    return ErrorResponseModel("An error occurred.", status.HTTP_404_NOT_FOUND, "Car(s) don't exist.")


# Drowsiness detection for a user
@ router.post("/face/drowsy/start", response_description="Drowsiness monitoring for the user")
async def start_drowsiness_detection(background_tasks: BackgroundTasks):
    background_tasks.add_task(detect_drowsiness, True)
    return("Drowsiness monitoring ON")


@ router.post("/face/drowsy/stop", response_description="Drowsiness monitoring for the user")
async def stop_drowsiness_detection():
    return("Drowsiness monitoring OFF")
