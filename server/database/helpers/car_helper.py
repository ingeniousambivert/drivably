import motor.motor_asyncio
from core.config import MONGO_URI

client = motor.motor_asyncio.AsyncIOMotorClient(MONGO_URI)
database = client["drivably"]
cars_collection = database["cars"]


def car_helper(car) -> dict:
    return {
        "id": str(car["_id"]),
        "car_license": car["car_license"],
        "car_name": car["car_name"],
        "owner": car["owner"],
        "drivers": car["drivers"],
        "current_location": car["current_location"],
        "alcohol_concentrations": car["alcohol_concentrations"],
        "casualties": car["casualties"],
        "activities": car["activities"],
        "created_at": car["created_at"],
        "updated_at": car["updated_at"],
    }
