import redis
import time
from time import sleep

client = redis.StrictRedis(host="localhost", port=6379, db=0)

data = {"key": "user", "value": "john"}

client.set(data["key"], data["value"])

print(client.get(data["key"]))

while client.get(data["key"]):
    print(time.asctime(time.localtime(time.time())))
    print(client.get(data["key"]))


print("Deleted")


# set TTL - (Time To Live) for Variable
# Key = "Name"
# value = "Vijay"
# TTL_in_sec = 30
# client.set(Key, value)
# print(client.expire(Key, TTL_in_sec))
# print("Sec remaining : ", client.ttl(Key))
# sleep(15)
# print("Sec remaining : ", client.ttl(Key))
# sleep(15)
# print("Sec remaining : ", client.ttl(Key))
# print(client.get(Key))
