from typing import List, Optional, Dict
from pydantic import BaseModel, Field


class CarSchema(BaseModel):
    car_license: str = Field(...)
    car_name: str = Field(...)
    owner: str = Field(...)
    drivers: List[str] = Field(...)
    current_location: List[str] = Field(None)
    alcohol_concentrations: List[Dict] = Field(None)
    casualties: List[Dict] = Field(None)
    activities: List[Dict] = Field(None)
    created_at: str = Field(None)
    updated_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car_license": "car-license-1",
                "car_name": "car-1",
                "owner": "user-id-1",
                "drivers": ["user-id-2", "user-id-3", "user-id-4"],
                "current_location": ["40.758896", " - 73.985130"],
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-id-1",
                    }
                ],
                "casualties": [
                    {
                        "location": ["40.758896", " - 73.985130"],
                        "driver": "driver-id-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-id-1",
                        "data": "drowsiness_alert"
                    }
                ]

            }
        }


class UpdateCarModel(BaseModel):
    car_license:  Optional[str]
    car_name:  Optional[str]
    owner:  Optional[str]
    drivers: Optional[List[str]]

    class Config:
        schema_extra = {
            "example": {
                "car_license": "car-license-1",
                "car_name": "car-1",
                "owner": "user-id-1",
                "drivers": ["user-id-2", "user-id-3"],
                "current_location": ["40.758896", " - 73.985130"],
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-id-1",
                    }
                ],
                "casualties": [
                    {
                        "location": ["40.758896", " - 73.985130"],
                        "driver": "driver-id-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-id-1",
                        "data": "drowsiness_alert"
                    }
                ]

            }
        }


def ResponseModel(data, message):
    return {
        "data": [data],
        "code": 200,
        "message": message,
    }


def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}
