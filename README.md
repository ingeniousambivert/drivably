# Drivably - Car Safety Assistant with IoT

Software Development Project - TY BCA - GLS

## Drowsiness Detection

>Drowsiness detection system with OpenCV

#### Description

A computer vision system that can automatically detect driver drowsiness in a real-time video stream and then play an alarm if the driver appears to be drowsy.

#### Algorithm

Each eye is represented by 6 (x, y)-coordinates, starting at the left-corner of the eye (as if you were looking at the person), and then working clockwise around the eye:.

#### Condition

It checks 20 consecutive frames and if the Eye Aspect ratio is less than 0.25, Alert is generated.

## Getting Started

Getting up and running is simple.

1. Make sure you have [Python3](https://www.python.org/) and [pip](https://pip.pypa.io/en/stable/) installed.

2. Create a vitual environment for the script.

    ```bash
    python -m venv drivablyEnv
    source ./drivablyEnv/bin/activate
    ```

3. Install the dependencies.

    ```bash
    pip install -r requirements.txt
    ```

4. Start the script.

    ```bash
    python detect.py
    ```

#### Notes

For more information, read [this](https://www.pyimagesearch.com/2017/05/08/drowsiness-detection-opencv/).
