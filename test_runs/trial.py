# # # from multiprocessing import Pool
# # from detect import DrowsinessDetector

# # drowsy = DrowsinessDetector()
# # start = drowsy.start_monitoring()
# # stop = drowsy.stop_monitoring()


# # def run_process(process):
# #     return process


# # run_process(start)

# # for i in range(0, 200):
# #     if i == 180:
# #         run_process(stop)

# # # pool = Pool(processes=1)
# # # pool.map(run_process, start)


# import multiprocessing

# event = None


# def my_worker(num):
#     print("event is %s in child" % event)


# if __name__ == "__main__":
#     event = multiprocessing.Event()
#     pool = multiprocessing.Pool(2)
#     pool.map_async(
#         my_worker, [i for i in range(pool._processes)]
#     )  # Just call my_worker for every process in the pool.

#     pool.close()
#     pool.join()
#     print("event is %s in parent" % event)


# Check file for new data.

# import time

# f = open(r"./test.txt", "r")

# while True:

#     line = f.readline()
#     if not line:
#         time.sleep(1)
#         print("Nothing New")
#     else:
#         print("Call Function: ", line)


import redis
from time import sleep

client = redis.StrictRedis(host="localhost", port=6379, db=0)

data = {"key": "user", "value": "john"}

print(client.delete(data["key"]))


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