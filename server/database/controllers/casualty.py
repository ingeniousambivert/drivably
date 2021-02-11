from bson.objectid import ObjectId
import motor.motor_asyncio
from datetime import datetime

MONGO_URI: str = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

casualties_collection = database.get_collection("casualties")


# controller methods

def casualty_controller(casualty) -> dict:
    return {
        "id": str(casualty["_id"]),
        "car": casualty["car"],
        "location": casualty["location"],
        "driver": casualty["driver"],
        "created_at": casualty["created_at"],
    }


# Retrieve all casualties present in the database
async def retrieve_casualties():
    casualties = []
    async for casualty in casualties_collection.find():
        casualties.append(casualty_controller(casualty))
    return casualties


# Add a new casualty into to the database
async def add_casualty(casualty_data: dict) -> dict:
    casualty_data.update({"created_at": datetime.now()})
    casualty = await casualties_collection.insert_one(casualty_data)
    new_casualty = await casualties_collection.find_one({"_id": casualty.inserted_id})
    return casualty_controller(new_casualty)


# Retrieve a casualty with a matching ID
async def retrieve_casualty(id: str) -> dict:
    casualty = await casualties_collection.find_one({"_id": ObjectId(id)})
    if casualty:
        return casualty_controller(casualty)


# Delete a casualty from the database
async def delete_casualty(id: str):
    casualty = await casualties_collection.find_one({"_id": ObjectId(id)})
    if casualty:
        await casualties_collection.delete_one({"_id": ObjectId(id)})
        return True
