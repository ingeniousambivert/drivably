import face_recognition
known_image = face_recognition.load_image_file("./face/known/elon.jpg")
unknown_image = face_recognition.load_image_file("./face/unknown/jeff.jpg")

known_face_names = [
    "Elon Musk",
]

elon_face_encoding = face_recognition.face_encodings(known_image)[0]
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]

result = face_recognition.compare_faces(
    [elon_face_encoding], unknown_encoding)

if result is True:
    print(known_face_names[0])

print("Unknown Face")
