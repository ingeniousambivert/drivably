import face_recognition
known_image = face_recognition.load_image_file("./known/elon.jpg")
unknown_image = face_recognition.load_image_file("./unknown/jeff.jpg")

known_encoding = face_recognition.face_encodings(known_image)[0]
unknown_encoding = face_recognition.face_encodings(unknown_image)[0]

result = face_recognition.compare_faces(
    [known_encoding], unknown_encoding)

res = ''.join([str(elem) for elem in result])

if res == "True":
    print("Known Face")
else:
    print("Unknown Face")
