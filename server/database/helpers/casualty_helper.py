import motor.motor_asyncio
from core.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
database = client.drivably
casualties_collection = database.casualties


def casualty_helper(casualty) -> dict:
    return {
        "id": str(casualty["_id"]),
        "car": casualty["car"],
        "location": casualty["location"],
        "driver": casualty["driver"],
        "created_at": casualty["created_at"],
    }
