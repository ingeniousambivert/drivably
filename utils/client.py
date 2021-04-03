import httpx
import redis
from utils.config import (BASE_URL)

httpClient = httpx.Client(base_url=BASE_URL)
redisClient = redis.StrictRedis(host="localhost", port=6379, db=0)