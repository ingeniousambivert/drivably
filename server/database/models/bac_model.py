from typing import Optional
from pydantic import BaseModel, Field


class BacSchema(BaseModel):
    car: str = Field(...)
    value: float = Field(...)
    driver: str = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "car": "1M BT4M4N",
                "value": "12.8",
                "driver": "Bruce Wayne",
            }
        }


class UpdateBacModel(BaseModel):
    car:  Optional[str]
    value:  Optional[float]
    driver:  Optional[str]

    class Config:
        schema_extra = {
            "example": {
                "car": "911",
                "value": "21.09",
                "driver": "Osama Bin Laden",
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
