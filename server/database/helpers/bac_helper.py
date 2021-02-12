
import motor.motor_asyncio
from core.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
database = client.drivably
bac_collection = database.bac


def bac_helper(bac) -> dict:
    return {
        "id": str(bac["_id"]),
        "car": bac["car"],
        "value": bac["value"],
        "driver": bac["driver"],
        "created_at": bac["created_at"],
    }
