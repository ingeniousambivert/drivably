from typing import Optional
from pydantic import BaseModel, Field


class ActivitySchema(BaseModel):
    car: str = Field(...)
    diver: str = Field(...)
    data: str = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car": "Bat Mobile",
                "driver": "Bruce Wayne",
                "data": "Drowsiness Alert",
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
