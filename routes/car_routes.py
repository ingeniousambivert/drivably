from utils.client.http import (httpClient, httpError)
from utils.helpers import (access_token, auth_headers, content_headers)


def update_car_attributes(license, data):
    try:
        if access_token is not None:
            response = httpClient.post(
                f"/car/attribute/{license}", headers={**auth_headers, **content_headers}, json=data)
            response.raise_for_status()
        else:
            print("User access token not found or expired")
    except httpError as exc:
        print(f"An error occured for {exc.request.url} - {exc}")

    finally:
        httpClient.close()
