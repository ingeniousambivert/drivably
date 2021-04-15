# Drivably - Car Safety Assistant with IoT

Software Development Project - TY BCA - GLS

## Server

>Fast API Server for Drivably

## Getting Started

Getting up and running is simple.

1. Make sure you have [Python3](https://www.python.org/), [pip](https://pip.pypa.io/en/stable/) and [MongoDB](https://www.mongodb.com/) installed.

2. Create a vitual environment for the server.

    ```bash
    python -m venv serverEnv
    source ./drivablyEnv/bin/activate
    ```

3. Install your dependencies.

    ```bash
    pip install -r requirements.txt
    ```

4. Configuring the server with environment variables
    - Create a `.env` file in the root
    - Add the following lines to it (modify according to your environment/requirements)

    ```env
     # configure your email host details here
    MAIL_USERNAME=username
    MAIL_PASSWORD=password
    MAIL_FROM=your@email.com
    MAIL_PORT=587
    MAIL_SERVER=your.mail.server

    # configure your local/remote mongodb server here
    MONGO_URI=mongodb://localhost:27017

    # configure your JWT details here
    # Do not use the sample string below, to get a hex string run: openssl rand -hex 32
    JWT_SECRET=eeb7b4544c80a3b26cc87e0d76d664d7a2d9af75a8fa56818ffffb611e5ec4ea
    JWT_ALGORITHM=HS256
    ```

5. Start your server.

    ```bash
    python main.py
    ```

6. Open [http://localhost:8008](http://localhost:8008) to view it in the browser.

### Notes

Checkout the Swagger UI for API docs - [http://localhost:8008/docs](http://localhost:8008/docs)

#### Setup on Raspberry Pi

- OpenCV

```
sudo apt-get install libhdf5-dev libhdf5-serial-dev libhdf5-100
sudo apt-get install libqtgui4 libqtwebkit4 libqt4-test
sudo apt-get install libatlas-base-dev
sudo apt-get install libjasper-dev
wget <https://bootstrap.pypa.io/get-pip.py>​
sudo python3 get-pip.py
sudo pip3 install opencv-contrib-python
```

- MongoDB - [MongoDB Setup on Raspberry Pi](https://developer.mongodb.com/how-to/mongodb-on-raspberry-pi/)

##### Quick Fixes

While importing opencv if you get error like "ImportError: /usr/local/lib/python3.7/dist-packages/cv2/cv2.cpython-37m-arm-linux-gnueabihf.so: undefined symbol: __atomic_fetch_add_8" ,then try the below command:

```
sudo pip3 install opencv-contrib-python==3.4.6.27
```

this command as the latest version of openCV doesn't work with RPi.

After this if you get "ImportError: libhdf5_serial.so.103: cannot open shared object file: No such file or directory" - this error then try the below command:

```
sudo apt-get install python3-h5py
```
