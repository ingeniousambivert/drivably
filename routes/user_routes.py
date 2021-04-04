from utils.client.http import (httpClient, httpError)
from utils.client.redis import redisClient
from utils.helpers import (access_token, auth_headers, content_headers)


def authenticate_user(data):
    with httpClient as client:
        try:
            response = client.post("/driver/signin", json=data)
            token = response.json()["access_token"]
            redisClient.set("access_token", token)
            print(f"authenticate_user : {response.status_code}")
            response.raise_for_status()
        except httpError as exc:
            print(f"An error occured for {exc.request.url} - {exc}")


def get_user(email):
    with httpClient as client:
        try:
            if access_token is not None:
                response = client.get(
                    f"/user/{email}", headers={**auth_headers, **content_headers})
                print(response.json())
                response.raise_for_status()
            else:
                print("User access token not found")
        except httpError as exc:
            print(f"An error occured for {exc.request.url} - {exc}")
