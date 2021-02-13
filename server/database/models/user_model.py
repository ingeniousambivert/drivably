from typing import List, Optional
from pydantic import BaseModel, EmailStr, Field


class UserSchema(BaseModel):
    name: str = Field(...)
    email: EmailStr = Field(...)
    password: str = Field(...)
    facial_data: Optional[str] = Field(...)
    cars: Optional[List[str]] = Field(...)
    phone: Optional[float] = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "name": "John Doe",
                "email": "john@doe.com",
                "password": "doe",
                "facial_data": "./faces/JohnDoe_Face.jpg",
                "cars": ["car-id-1", "car-id-2"],
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
                "password": "does",
                "facial_data": "./faces/JohnDoes_Face.jpg",
                "cars": ["car-id-1", "car-id-2"],
                "phone": "1234567890",
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
