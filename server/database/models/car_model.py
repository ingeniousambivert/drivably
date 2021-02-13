from typing import List, Optional
from pydantic import BaseModel, Field


class CarSchema(BaseModel):
    car_license: str = Field(...)
    car_name: str = Field(...)
    owner: str = Field(...)
    drivers: List[str] = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car_license": "car-license-1",
                "car_name": "car-1",
                "owner": "user-id-1",
                "drivers": ["user-id-2", "user-id-3", "user-id-4"],
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
