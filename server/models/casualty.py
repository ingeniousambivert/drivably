from typing import List, Optional
from pydantic import BaseModel, Field


class CasualtySchema(BaseModel):
    car: str = Field(...)
    location: List[str] = Field(...)
    driver: str = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car": "988bu87g76gby76f8h897g",
                "location": ["62.9689778987", "56.987987687"],
                "driver": "Bruce Wayne",
            }
        }


class UpdateCasualtyModel(BaseModel):
    car:  Optional[str]
    location:  Optional[List[str]]
    driver:  Optional[str]

    class Config:
        schema_extra = {
            "example": {
                "car": "988bu87g76gby76f8h897g",
                "location": ["122.9689778987", "86.987987687"],
                "driver": "Jason Todd",
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
