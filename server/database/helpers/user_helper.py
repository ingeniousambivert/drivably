import motor.motor_asyncio
from server.utils.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
database = client["drivably"]
users_collection = database["users"]


def user_helper(user) -> dict:
    return {
        "id": str(user["_id"]),
        "name": user["name"],
        "facial_data": user["facial_data"],
        "email": user["email"],
        "password": user["password"],
        "cars": user["cars"],
        "phone": user["phone"],
        "created_at": user["created_at"],
    }


def safe_user(user) -> dict:
    return {
        "id": str(user["id"]),
        "name": user["name"],
        "facial_data": user["facial_data"],
        "email": user["email"],
        "cars": user["cars"],
        "phone": user["phone"],
        "created_at": user["created_at"],
    }
