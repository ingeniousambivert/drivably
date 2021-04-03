import httpx
from utils.config import (BASE_URL)

client = httpx.Client()


def authenticate_user(data):
    try:
        r = client.post(f"{BASE_URL}/owner/signin", json=data)
        print(r.json())
    except:
        print("An error occurred")

    finally:
        client.close()
