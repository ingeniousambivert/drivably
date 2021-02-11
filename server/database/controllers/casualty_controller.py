from bson.objectid import ObjectId
from datetime import datetime

from server.database.helpers.casualty_helper import casualties_collection, casualty_helper


# Retrieve all casualties present in the database
async def retrieve_casualties():
    casualties = []
    async for casualty in casualties_collection.find():
        casualties.append(casualty_helper(casualty))
    return casualties


# Add a new casualty into to the database
async def add_casualty(casualty_data: dict) -> dict:
    casualty_data.update({"created_at": datetime.now()})
    casualty = await casualties_collection.insert_one(casualty_data)
    new_casualty = await casualties_collection.find_one({"_id": casualty.inserted_id})
    return casualty_helper(new_casualty)


# Retrieve a casualty with a matching ID
async def retrieve_casualty(id: str) -> dict:
    casualty = await casualties_collection.find_one({"_id": ObjectId(id)})
    if casualty:
        return casualty_helper(casualty)


# Delete a casualty from the database
async def delete_casualty(id: str):
    casualty = await casualties_collection.find_one({"_id": ObjectId(id)})
    if casualty:
        await casualties_collection.delete_one({"_id": ObjectId(id)})
        return True
