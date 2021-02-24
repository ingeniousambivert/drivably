import motor.motor_asyncio
from server.utils.config import configured

client = motor.motor_asyncio.AsyncIOMotorClient(configured.MONGO_URI)
database = client["drivably"]
cars_collection = database["cars"]


def car_helper(car) -> dict:
    return {
        # "id": str(car["_id"]),
        "car_license": car["car_license"],
        "car_name": car["car_name"],
        "owner_email": car["owner_email"],
        "drivers_email": car["drivers_email"],
        "current_location": car["current_location"],
        "alcohol_concentrations": car["alcohol_concentrations"],
        "casualties": car["casualties"],
        "activities": car["activities"],
        "created_at": car["created_at"],
    }
