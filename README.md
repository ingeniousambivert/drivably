# Drivably - Car Safety Assistant with IoT

Software Development Project - TY BCA - GLS

## Server

>Fast API Server for Drivably

## Getting Started

Getting up and running is simple.

1. Make sure you have [Python3](https://www.python.org/), [pip](https://pip.pypa.io/en/stable/) and [MongoDB](https://www.mongodb.com/) installed.

2. Create a vitual environment for the server.

    ```bash
    python -m venv drivablyEnv
    source ./drivablyEnv/bin/activate
    ```

3. Install your dependencies.

    ```bash
    pip install -r requirements.txt
    ```

4. Configuring the server with environment variables
    - Create a `.env` file in the root
    - Add the following lines to it (modify according to your environment/needs)

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
