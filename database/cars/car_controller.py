from bson.objectid import ObjectId
from datetime import datetime
from database.aggregation.pipelines import aggregate_lookup_owner
from server.services.cars.helpers.car_helper import cars_collection, car_helper


# Retrieve all cars present in the database
async def retrieve_cars():
    cars = []
    async for car in cars_collection.find():
        cars.append(car_helper(car))
    return cars


# Add a new car into to the database
async def add_car(car_data: dict) -> dict:
    car_data.update({"created_at": datetime.now()})
    car = await cars_collection.insert_one(car_data)
    new_car = await cars_collection.find_one({"_id": car.inserted_id})
    return car_helper(new_car)


# Retrieve a car with a matching ID
async def retrieve_car(id: str) -> dict:
    car = await cars_collection.find_one({"_id": ObjectId(id)})
    if car:
        return car_helper(car)


# Update a car with a matching ID
async def update_car(id: str, car_data: dict):
    # Return false if an empty request body is sent.
    if len(car_data) < 1:
        return False

    car = await cars_collection.find_one({"_id": ObjectId(id)})

    if car:
        car_data.update({"updated_at": datetime.now()})
        updated_car = await cars_collection.update_one(
            {"_id": ObjectId(id)}, {"$set": car_data}
        )
        if updated_car:
            return True
        return False


# Update ARRAY ATTRIBUTES of a car with a matching ID
async def update_car_array_attributes(id: str, car_attribute: str, car_attribute_data: dict):

    car = await cars_collection.find_one({"_id": ObjectId(id)})

    if car:
        car_attribute_data["created_at"] = datetime.now()
        updated_car_attribute = await cars_collection.update_one(
            {"_id": ObjectId(id)}, {
                "$push": {car_attribute: car_attribute_data}, }
        )
        if updated_car_attribute:
            return True
        return False


# Delete a car from the database
async def delete_car(id: str):
    car = await cars_collection.find_one({"_id": ObjectId(id)})
    if car:
        await cars_collection.delete_one({"_id": ObjectId(id)})
        return True


# Retrieve a car with a matching ID
# async def retrieve_car_owner():
#     # car = await cars_collection.find_one({"_id": ObjectId(id)})
#     pipeline = {"from": "users",
#                 "localField": "owner_email",
#                 "foreignField": "email",
#                 "as": "owner_data"}
#     car_owner = await aggregate_lookup_owner(cars_collection, **pipeline)
#     return car_owner
