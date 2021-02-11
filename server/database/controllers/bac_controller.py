from bson.objectid import ObjectId
from datetime import datetime

from server.database.helpers.bac_helper import bac_collection, bac_helper


# Retrieve all bac present in the database
async def retrieve_all_bac():
    all_bac = []
    async for bac in bac_collection.find():
        all_bac.append(bac_helper(bac))
    return all_bac


# Add a new bac into to the database
async def add_bac(bac_data: dict) -> dict:
    bac_data.update({"created_at": datetime.now()})
    bac = await bac_collection.insert_one(bac_data)
    new_bac = await bac_collection.find_one({"_id": bac.inserted_id})
    return bac_helper(new_bac)


# Retrieve a bac with a matching ID
async def retrieve_bac(id: str) -> dict:
    bac = await bac_collection.find_one({"_id": ObjectId(id)})
    if bac:
        return bac_helper(bac)


# Update a bac with a matching ID
async def update_bac(id: str, bac_data: dict):
    # Return false if an empty request body is sent.
    if len(bac_data) < 1:
        return False

    bac = await bac_collection.find_one({"_id": ObjectId(id)})

    if bac:
        bac_data.update({"updated_at": datetime.now()})
        updated_bac = await bac_collection.update_one(
            {"_id": ObjectId(id)}, {"$set": bac_data}
        )
        if updated_bac:
            return True
        return False


# Delete a bac from the database
async def delete_bac(id: str):
    bac = await bac_collection.find_one({"_id": ObjectId(id)})
    if bac:
        await bac_collection.delete_one({"_id": ObjectId(id)})
        return True
