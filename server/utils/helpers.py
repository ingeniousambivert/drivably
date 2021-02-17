import shutil
import os
from pathlib import Path
from tempfile import NamedTemporaryFile
from typing import Callable

from fastapi import UploadFile
from server.database.helpers.car_helper import cars_collection


async def check_car_exists(car_license: str):
    car = await cars_collection.find_one({"car_license": car_license}, {"_id": 0})
    if car:
        return True
    return False


def save_upload_file(upload_file: UploadFile, file_name: str) -> None:
    try:
        if not os.path.exists("data/faces/"):
            os.makedirs("data/faces/")

        file_location = f"data/faces/{file_name}_Face.png"
        with open(file_location, "wb+") as file_object:
            shutil.copyfileobj(upload_file.file, file_object)
        return {"filename": file_name+"_Face", "location": file_location}
    finally:
        upload_file.file.close()


def save_upload_file_tmp(upload_file: UploadFile) -> Path:
    try:
        suffix = Path(upload_file.filename).suffix
        with NamedTemporaryFile(delete=False, suffix=suffix) as tmp:
            shutil.copyfileobj(upload_file.file, tmp)
            tmp_path = Path(tmp.name)
    finally:
        upload_file.file.close()
    return tmp_path


def handle_upload_file(upload_file: UploadFile, handler: Callable[[Path], None]) -> None:
    tmp_path = save_upload_file_tmp(upload_file)
    try:
        handler(tmp_path)  # Do something with the saved temp file
    finally:
        tmp_path.unlink()  # Delete the temp file
