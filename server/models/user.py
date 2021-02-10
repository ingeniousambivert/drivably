from typing import List, Optional
from pydantic import BaseModel, EmailStr, SecretStr, Field


class UserSchema(BaseModel):
    fullname: str = Field(...)
    email: EmailStr = Field(...)
    password: SecretStr = Field(...)
    facial_data: str = Field(...)
    cars: List[str] = Field(...)
    phone: float = Field(...)
    created_at: str = Field(None)

    class Config:
        schema_extra = {
            "example": {
                "fullname": "John Doe",
                "email": "john@doe.com",
                "password": "johndoe123",
                "facial_data": "./faces/JohnDoe_Face.jpg",
                "cars": ["sasjniluh8989p8uunih8", "baskjb878huo8as7iho87"],
                "phone": "0123456789",
            }
        }


class UpdateUserModel(BaseModel):
    fullname: Optional[str]
    email: Optional[EmailStr]
    password: Optional[SecretStr]
    facial_data: str = Field(...)
    cars: Optional[List[str]]
    phone: Optional[float]

    class Config:
        schema_extra = {
            "example": {
                "fullname": "John Does",
                "email": "john@does.com",
                "password": "johndoes123",
                "facial_data": "./faces/JohnDoe_Face.jpg",
                "cars": ["baskjb878huo8as7iho87", "sasjniluh8989p8uunih8"],
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
