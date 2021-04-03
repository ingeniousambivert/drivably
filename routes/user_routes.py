from utils.client import(httpClient, httpError, redisClient)


def authenticate_user(data):
    try:
        response = httpClient.post("/owner/signin", json=data)
        token = response.json()["access_token"]
        auth_data = {"key": "access_token", "value": token}
        redisClient.set(auth_data["key"], auth_data["value"])
        response.raise_for_status()
    except httpError as exc:
        print(f"HTTP Exception for {exc.request.url} - {exc}")

    finally:
        httpClient.close()
