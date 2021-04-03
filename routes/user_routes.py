
from utils.config import (BASE_URL)
from utils.client import(httpClient, redisClient)


def authenticate_user(data):
    try:
        response = httpClient.post(f"{BASE_URL}/owner/signin", json=data)
        token = response.json()["access_token"]
        auth_data = {"key": "access_token", "value": token}
        redisClient.set(auth_data["key"], auth_data["value"])
    except:
        print("An error occurred: authentication")

    finally:
        httpClient.close()
