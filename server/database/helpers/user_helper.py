import motor.motor_asyncio
from core.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

users_collection = database.get_collection("users")


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
