import os
import face_recognition
from server.services.users.models.user_model import (
    ErrorResponseModel, ResponseModel)
from server.utils.helpers import remove_dir_tree


def recognize(user, temp_user):
    dirs = []
    user_found: bool = False
    known_dataset_path = f"intelligence/facial_recognition/dataset/known_facial_data/"
    unknown_dataset_path = f"intelligence/facial_recognition/dataset/unknown_facial_data/"

    if not user["facial_data"]:
        return ErrorResponseModel("Not Found", 404, "Could not find facial data.")
    else:
        user_file = f"user_{user['id']}"

        with os.scandir(known_dataset_path) as folders:
            for entry in folders:
                dirs.append(entry.name)

        for single_dir in dirs:
            if single_dir == user_file:
                user_found = True

        if user_found:
            known_image = face_recognition.load_image_file(
                f"{known_dataset_path}{user_file}/{user_file}_Face.png")
            unknown_image = face_recognition.load_image_file(
                f"{unknown_dataset_path}{temp_user}/{temp_user}_Face.png")

            known_face_encoding = face_recognition.face_encodings(known_image)[
                0]
            unknown_encoding = face_recognition.face_encodings(unknown_image)[
                0]
            result_array = face_recognition.compare_faces(
                [known_face_encoding], unknown_encoding)
            result_str = ''.join([str(elem) for elem in result_array])
            if result_str == "True":
                remove_dir_tree(f"{unknown_dataset_path}{temp_user}")
                return ResponseModel(
                    "Authenticated", 200, "Facial data authenticated")
            return ErrorResponseModel("Not Authenticated", 401, "Invalid facial data")

        return ErrorResponseModel("Not Found", 404, "Could not find user in storage")
