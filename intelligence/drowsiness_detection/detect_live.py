import dlib
import cv2
from scipy.spatial import distance
from imutils import face_utils

from multiprocessing import Process, Event


def eye_aspect_ratio(eye):
    A = distance.euclidean(eye[1], eye[5])
    B = distance.euclidean(eye[2], eye[4])
    C = distance.euclidean(eye[0], eye[3])
    ear = (A + B) / (2.0 * C)
    return ear


class DrowsinessDetector(Process):

    running = Event()

    def stop_monitoring(self):
        if self.running.is_set():
            self.running.clear()

    def start_monitoring(self):
        if self.running.is_set():
            return

        self.running.set()
        self.detect_drowsiness()

    def detect_drowsiness(self):
        thresh = 0.25
        frame_check = 18
        detect = dlib.get_frontal_face_detector()
        # Dat file is the crux of the code
        predict = dlib.shape_predictor(
            "intelligence/drowsiness_detection/dataset/shape_predictor_68_face_landmarks.dat")

        (lStart, lEnd) = face_utils.FACIAL_LANDMARKS_68_IDXS["left_eye"]
        (rStart, rEnd) = face_utils.FACIAL_LANDMARKS_68_IDXS["right_eye"]
        cap = cv2.VideoCapture(0)
        flag = 0
        while self.running.is_set():
            ret, frame = cap.read()
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            subjects = detect(gray, 0)
            for subject in subjects:
                shape = predict(gray, subject)
                shape = face_utils.shape_to_np(
                    shape)  # converting to NumPy Array
                leftEye = shape[lStart:lEnd]
                rightEye = shape[rStart:rEnd]
                leftEAR = eye_aspect_ratio(leftEye)
                rightEAR = eye_aspect_ratio(rightEye)
                ear = (leftEAR + rightEAR) / 2.0
                if ear < thresh:
                    flag += 1
                    print("Detecting,{}".format(flag))
                    if flag >= frame_check:
                        print("ALERT - Drowsy")

                else:
                    flag = 0
        cap.release()
