import motor.motor_asyncio
from core.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)

database = client.drivably

activities_collection = database.get_collection("activities")


def activity_helper(activity) -> dict:
    return {
        "id": str(activity["_id"]),
        "car": activity["car"],
        "driver": activity["driver"],
        "data": activity["data"],
        "created_at": activity["created_at"],
    }
