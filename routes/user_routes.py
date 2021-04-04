from utils.client import(httpClient, httpError,
                         redisClient, auth_headers, access_token)


def authenticate_user(data):
    with httpClient as client:
        try:
            response = client.post("/driver/signin", json=data)
            token = response.json()["access_token"]
            redisClient.set("access_token", token)
            print("authenticate_user : {}".format(
                response.status_code))
            response.raise_for_status()
        except httpError as exc:
            print(f"An error occured for {exc.request.url} - {exc}")


def get_users():
    with httpClient as client:
        try:
            if access_token is not None:
                response = client.get("/user/", headers=auth_headers)
                print(response.json())
                response.raise_for_status()
            else:
                print("User access token not found or expired")
        except httpError as exc:
            print(f"An error occured for {exc.request.url} - {exc}")
