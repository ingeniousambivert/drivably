from typing import List, Optional, Dict
from pydantic import BaseModel, Field


class CarSchema(BaseModel):
    car_license: str = Field(...)
    car_name: str = Field(...)
    owner_email: str = Field(...)
    current_location: Optional[Dict]
    # attributes start
    drivers_email: Optional[List[str]]
    alcohol_concentrations: Optional[List[Dict]]
    casualties: Optional[List[Dict]]
    activities: Optional[List[Dict]]
    # attributes end
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car_license": "car-license-1",
                "car_name": "car-1",
                "owner_email": "john@doe.com",
                "drivers_email": ["jane@doe.com", "jake@doe.com"],
                "current_location": {
                    "latitude": "40.758896",
                    "longitude": "-73.985130",
                },
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-id-1",
                    }
                ],
                "casualties": [
                    {
                        "location": {
                            "latitude": "40.758896",
                            "longitude": "-73.985130",
                        },
                        "driver": "driver-id-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-id-1",
                        "data": "drowsiness_alert"
                    }
                ],

            }
        }


class UpdateCarModel(BaseModel):
    car_license:  Optional[str]
    car_name:  Optional[str]
    owner_email:  Optional[str]
    drivers_email: Optional[List[str]]
    current_location: Optional[Dict]
    alcohol_concentrations: Optional[List[Dict]]
    casualties: Optional[List[Dict]]
    activities: Optional[List[Dict]]

    class Config:
        schema_extra = {
            "example": {
                "car_license": "car-license-1",
                "car_name": "car-1",
                "owner_email": "john@doe.com",
                "drivers_email": ["jane@doe.com", "jake@doe.com"],
                "current_location": {
                    "latitude": "40.758896",
                    "longitude": "-73.985130",
                },
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-id-1",
                    }
                ],
                "casualties": [
                    {
                        "location": {
                            "latitude": "40.758896",
                            "longitude": "-73.985130",
                        },
                        "driver": "driver-id-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-id-1",
                        "data": "drowsiness_alert"
                    }
                ],

            }
        }


def ResponseModel(data, code, message):
    return {
        "data": data,
        "code": code,
        "message": message,
    }


def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}
