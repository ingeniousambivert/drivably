import httpx
import redis

httpClient = httpx.Client()
redisClient = redis.StrictRedis(host="localhost", port=6379, db=0)
