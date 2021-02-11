from datetime import datetime
from bson.objectid import ObjectId

from server.database.helpers.activity_helper import activities_collection, activity_helper


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
