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


# Retrieve a user with a matching EMAIL
async def retrieve_user(email: str) -> dict:
    user = await users_collection.find_one({"email": email})  # , {"_id": 0}
    if user:
        return user_helper(user)


# Update a user with a matching email
async def update_user(email: str, user_data: dict):
    user = await users_collection.find_one({"email": email})
    if user:
        user_data.update({"updated_at": datetime.now()})
        updated_user = await users_collection.update_one(
            {"email": email}, {"$set": user_data}
        )
        if updated_user:
            return True
        return False


# Add car driver
async def add_car_driver(email: str, license_number: str):

    user = await users_collection.find_one({"email": email})

    if user:
        updated_user_car = await users_collection.update_one(
            {"email": email}, {
                "$push": {"cars": license_number}, }
        )
        if updated_user_car:
            return True
        return False


# Delete a user from the database
async def delete_car(email: str, license_number: str):
    user = await users_collection.find_one({"email": email})
    if user:
        updated_user = await users_collection.update_one(
            {"email": email}, {
                "$pull": {"cars": license_number}, }
        )
        if updated_user:
            return True
        return False


# Delete a user from the database
async def delete_user(email: str):
    user = await users_collection.find_one({"email": email})
    if user:
        await users_collection.delete_one({"email": email})
        return True
    return False


# Retrieve owners car
async def retrieve_car_data(email: str):
    owner_car = await aggregate_match_owner(email)
    return owner_car
