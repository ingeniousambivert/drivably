import face_recognition


def detect_face(image):
    detect_image = face_recognition.load_image_file(image)
    face_locations = face_recognition.face_locations(detect_image)

    if len(face_locations) > 0:
        return True
    else:
        return False
