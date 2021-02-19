from typing import Optional, Dict
from pydantic import BaseModel, Field


class ProfileSchema(BaseModel):
    user: str = Field(...)
    car: str = Field(...)
    options: Dict = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "user": "user-1-id",
                "car": "car-1-id",
                "options": {
                    "max_speed": 60,
                    "max_volume": 70,
                },

            }
        }


class UpdateProfileModel(BaseModel):
    user: Optional[str]
    car: Optional[str]
    options: Optional[str]

    class Config:
        schema_extra = {
            "example": {
                "user": "user-1-id",
                "car": "car-1-id",
                "options": {
                    "max_speed": 50,
                    "max_volume": 40,
                },

            }
        }


def ResponseModel(data):
    return data

# def ResponseModel(data, message):
#     return {
#         "data": [data],
#         "code": 200,
#         "message": message,
#     }


def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}
