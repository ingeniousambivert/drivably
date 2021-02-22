from bson.objectid import ObjectId
from datetime import datetime
from server.services.users.helpers.user_helper import users_collection, user_helper
from database.aggregation.pipelines import aggregate_match_owner


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


# Retrieve a user with a matching EMAIL
async def retrieve_user_by_email(email: str) -> dict:
    user = await users_collection.find_one({"email": email})  # , {"_id": 0}
    if user:
        return user_helper(user)


# Update a user with a matching ID
async def update_user(id: str, user_data: dict):
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


# Retrieve owners car
async def retrieve_car_data(email: str):
    owner_car = await aggregate_match_owner(email)
    return owner_car
