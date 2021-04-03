# Drivably - Car Safety Assistant with IoT

Software Development Project - TY BCA - GLS

## RasPi Client

>Raspberry Pi Client for Drivably

## Getting Started

Getting up and running is simple.

1. Make sure you have [Python3](https://www.python.org/), [pip](https://pip.pypa.io/en/stable/) installed.

2. Create a vitual environment for the client.

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
    - Add the following lines to it (modify according to your environment/requirements)

    ```env
    # configure your auth details here
    AUTH_USERNAME=username/email
    AUTH_PASSWORD=password
    BASE_URL=localhost/remote URL
    ```

5. Execute the client.

    ```bash
    python main.py
    ```
