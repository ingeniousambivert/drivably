import motor.motor_asyncio
from server.utils.config import configured

client = motor.motor_asyncio.AsyncIOMotorClient(configured.MONGO_URI)
database = client["drivably"]
users_collection = database["users"]


def user_helper(user) -> dict:
    return {
        "id": str(user["_id"]),
        "name": user["name"],
        "email": user["email"],
        "phone": user["phone"],
        "owner": user["owner"],
        "facial_data": user["facial_data"],
        "cars": user["cars"],
        "created_at": user["created_at"],
    }
