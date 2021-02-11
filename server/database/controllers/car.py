from bson.objectid import ObjectId
import motor.motor_asyncio
from datetime import datetime

MONGO_URI: str = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

cars_collection = database.get_collection("cars")


# controller methods

def car_controller(car) -> dict:
    return {
        "id": str(car["_id"]),
        "car_license": car["car_license"],
        "car_name": car["car_name"],
        "owner": car["owner"],
        "drivers": car["drivers"],
        "created_at": car["created_at"],
    }


# Retrieve all cars present in the database
async def retrieve_cars():
    cars = []
    async for car in cars_collection.find():
        cars.append(car_controller(car))
    return cars


# Add a new car into to the database
async def add_car(car_data: dict) -> dict:
    car_data.update({"created_at": datetime.now()})
    car = await cars_collection.insert_one(car_data)
    new_car = await cars_collection.find_one({"_id": car.inserted_id})
    return car_controller(new_car)


# Retrieve a car with a matching ID
async def retrieve_car(id: str) -> dict:
    car = await cars_collection.find_one({"_id": ObjectId(id)})
    if car:
        return car_controller(car)


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


# Delete a car from the database
async def delete_car(id: str):
    car = await cars_collection.find_one({"_id": ObjectId(id)})
    if car:
        await cars_collection.delete_one({"_id": ObjectId(id)})
        return True
