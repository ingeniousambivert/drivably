import motor.motor_asyncio
from server.utils.config import configured

client = motor.motor_asyncio.AsyncIOMotorClient(configured.MONGO_URI)
database = client["drivably"]
profiles_collection = database["profiles"]


def profile_helper(profile) -> dict:
    return {
        "id": str(profile["_id"]),
        "user": profile["user"],
        "car": profile["car"],
        "options": profile["options"],
        "created_at": profile["created_at"],
    }
