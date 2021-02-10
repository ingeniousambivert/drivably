from bson.objectid import ObjectId
import motor.motor_asyncio
from datetime import datetime

MONGO_URI: str = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

activities_collection = database.get_collection("activities")


# helper methods

def activity_helper(activity) -> dict:
    return {
        "id": str(activity["_id"]),
        "car": activity["car"],
        "driver": activity["driver"],
        "data": activity["data"],
        "created_at": activity["created_at"],
    }


# Retrieve all activities present in the database
async def retrieve_activities():
    activities = []
    async for activity in activities_collection.find():
        activities.append(activity_helper(activity))
    return activities


# Add a new activity into to the database
async def add_activity(activity_data: dict) -> dict:
    activity_data.update({"created_at": datetime.now()})
    activity = await activities_collection.insert_one(activity_data)
    new_activity = await activities_collection.find_one({"_id": activity.inserted_id})
    return activity_helper(new_activity)


# Retrieve a activity with a matching ID
async def retrieve_activity(id: str) -> dict:
    activity = await activities_collection.find_one({"_id": ObjectId(id)})
    if activity:
        return activity_helper(activity)


# Delete a activity from the database
async def delete_activity(id: str):
    activity = await activities_collection.find_one({"_id": ObjectId(id)})
    if activity:
        await activities_collection.delete_one({"_id": ObjectId(id)})
        return True
