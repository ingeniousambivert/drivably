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


def ResponseModel(data, code, message):
    return {
        "data": data,
        "code": code,
        "message": message,
    }


def ErrorResponseModel(error, code, message):
    return {"error": error, "code": code, "message": message}
