from server.database.helpers.car_helper import cars_collection


async def check_car_exists(car_license: str):
    car = await cars_collection.find_one({"car_license": car_license}, {"_id": 0})
    if car:
        return True
    return False
