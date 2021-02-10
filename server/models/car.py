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
                "car_license": "1M BT4M4N",
                "car_name": "Bat Mobile",
                "owner": "Bruce Wayne",
                "drivers": ["Jason Todd", "Barbara Gordon"],
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
                "car_license": "911",
                "car_name": "Allah Hu Akbar",
                "owner": "Osama Bin Laden",
                "drivers": ["Saddam Hussein"],
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
