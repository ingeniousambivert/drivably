import httpx
import redis
from utils.config import (BASE_URL)

httpClient = httpx.Client(base_url=BASE_URL)
httpError = httpx.HTTPError
redisClient = redis.StrictRedis(
    host="localhost", port=6379, charset="utf-8", decode_responses=True)


access_token = redisClient.get("access_token")
auth_headers = {"Authorization": "Bearer {}".format(access_token)}
