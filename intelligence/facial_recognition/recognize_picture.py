import os
from fastapi import status
import face_recognition
from server.services.users.model.user_model import (
    ErrorResponseModel, ResponseModel)
from server.utils.helpers import remove_dir_tree
from .helpers import detect_face


def recognize(user, temp_user):
    dirs = []
    user_found: bool = False
    known_dataset_path = f"intelligence/facial_recognition/dataset/known_facial_data/"
    unknown_dataset_path = f"intelligence/facial_recognition/dataset/unknown_facial_data/"

    if not user["facial_data"]:
        return ErrorResponseModel("Not Found", status.HTTP_404_NOT_FOUND, "Could not find facial data.")
    else:
        user_file = f"user_{user['email']}"

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

            # if not detect_face(f"{unknown_dataset_path}{temp_user}/{temp_user}_Face.png"):
            #     os.remove(
            #         f"{unknown_dataset_path}{temp_user}/{temp_user}_Face.png")
            #     return ErrorResponseModel("Face Not Found", status.HTTP_400_BAD_REQUEST, "Could not find a face in the uploaded image")

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
                    "Authenticated", status.HTTP_200_OK, "Facial data authenticated")
            return ErrorResponseModel("NotAuthenticated", status.HTTP_401_UNAUTHORIZED, "Invalid facial data")

        return ErrorResponseModel("Not Found", status.HTTP_404_NOT_FOUND, "Could not find user in storage")
