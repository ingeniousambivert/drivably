from bson.objectid import ObjectId
import motor.motor_asyncio
from datetime import datetime

MONGO_URI = "mongodb://localhost:27017"

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

users_collection = database.get_collection("users")

# helper methods


def user_helper(user) -> dict:
    return {
        "id": str(user["_id"]),
        "fullname": user["fullname"],
        "email": user["email"],
        "phone": user["phone"],
        "created_at": user["created_at"],
    }


# Retrieve all users present in the database
async def retrieve_users():
    users = []
    async for user in users_collection.find():
        users.append(user_helper(user))
    return users


# Add a new user into to the database
async def add_user(user_data: dict) -> dict:
    user_data.update({"created_at": datetime.now()})
    user = await users_collection.insert_one(user_data)
    new_user = await users_collection.find_one({"_id": user.inserted_id})
    return user_helper(new_user)


# Retrieve a user with a matching ID
async def retrieve_user(id: str) -> dict:
    user = await users_collection.find_one({"_id": ObjectId(id)})
    if user:
        return user_helper(user)


# Update a user with a matching ID
async def update_user(id: str, user_data: dict):
    # Return false if an empty request body is sent.
    if len(user_data) < 1:
        return False

    user = await users_collection.find_one({"_id": ObjectId(id)})

    if user:
        user_data.update({"updated_at": datetime.now()})
        updated_user = await users_collection.update_one(
            {"_id": ObjectId(id)}, {"$set": user_data}
        )
        if updated_user:
            return True
        return False


# Delete a user from the database
async def delete_user(id: str):
    user = await users_collection.find_one({"_id": ObjectId(id)})
    if user:
        await users_collection.delete_one({"_id": ObjectId(id)})
        return True