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
                "owner_email": "owner-mail",
                "drivers_email": ["driver-email-1", "driver-email-2"],
                "current_location": {
                    "latitude": "40.758896",
                    "longitude": "-73.985130",
                },
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-email-1",
                    }
                ],
                "casualties": [
                    {
                        "location": {
                            "latitude": "40.758896",
                            "longitude": "-73.985130",
                        },
                        "driver": "driver-email-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-email-1",
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
                "owner_email": "owner-mail",
                "drivers_email": ["driver-email-1", "driver-email-2"],
                "current_location": {
                    "latitude": "40.758896",
                    "longitude": "-73.985130",
                },
                "alcohol_concentrations": [
                    {
                        "value": "21.09",
                        "driver": "driver-email-1",
                    }
                ],
                "casualties": [
                    {
                        "location": {
                            "latitude": "40.758896",
                            "longitude": "-73.985130",
                        },
                        "driver": "driver-email-1",
                    }
                ],
                "activities": [
                    {
                        "driver": "driver-email-1",
                        "data": "drowsiness_alert"
                    }
                ],

            }
        }


def ResponseModel(data, status, message):
    return {
        "data": data,
        "status": status,
        "message": message,
    }


def ErrorResponseModel(error, status, message):
    return {"error": error, "status": status, "message": message}
