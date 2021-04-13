import redis 

redisClient = redis.StrictRedis(
    host="localhost", port=6379, charset="utf-8", decode_responses=True)