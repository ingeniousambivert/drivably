import httpx

from utils.config import (BASE_URL)

httpClient = httpx.Client(base_url=BASE_URL)
httpError = httpx.HTTPError
