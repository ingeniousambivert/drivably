import shutil
import os
import uuid

from fastapi import UploadFile
from server.database.helpers.car_helper import cars_collection

KNOWN_DATASET_PATH: str = "intelligence/facial_recognition/dataset/known_facial_data/"
UNKNOWN_DATASET_PATH: str = "intelligence/facial_recognition/dataset/unknown_facial_data/"


async def check_car_exists(car_license: str):
    car = await cars_collection.find_one({"car_license": car_license}, {"_id": 0})
    if car:
        return True
    return False


def save_upload_file(file_upload: UploadFile, file_name: str, dir_location: str) -> None:
    try:
        if not os.path.exists(dir_location):
            os.makedirs(dir_location)

        file_location = f"{dir_location}{file_name}"
        with open(file_location, "wb+") as file_object:
            uploaded = shutil.copyfileobj(file_upload.file, file_object)
            if not uploaded:
                return("An error occurred")
        return dir_location
        # return {"filename": file_name, "file_location": file_location, "dir_location": dir_location}
    finally:
        file_upload.file.close()


def remove_dir_tree(path):
    if shutil.rmtree(path):
        return True
    return False


def gen_uuid():
    return uuid.uuid4().hex
