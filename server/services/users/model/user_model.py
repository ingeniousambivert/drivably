from typing import List, Optional
from pydantic import BaseModel, EmailStr, Field


class UserSchema(BaseModel):
    name: str = Field(...)
    email: EmailStr = Field(...)
    password: str = Field(...)
    phone: Optional[float] = Field(...)
    facial_data: Optional[str]
    cars: Optional[List[str]]
    owner: bool = False
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "name": "John Doe",
                "email": "john@doe.com",
                "password": "doe",
                "phone": "0123456789",
            }
        }


class UpdateUserModel(BaseModel):
    name: Optional[str]
    email: Optional[EmailStr]
    password: Optional[str]
    facial_data: Optional[str]
    cars: Optional[List[str]]
    phone: Optional[float]

    class Config:
        schema_extra = {
            "example": {
                "name": "John Does",
                "email": "john@does.com",
                "cars": ["XX-01-ABC123", "XY-02-BCD234"]
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
