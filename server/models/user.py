from typing import Optional

from pydantic import BaseModel, EmailStr, Field


class UserSchema(BaseModel):
    fullname: str = Field(...)
    email: EmailStr = Field(...)
    phone: float = Field(...)

    class Config:
        schema_extra = {
            "example": {
                "fullname": "John Doe",
                "email": "john@doe.com",
                "phone": "0123456789",
            }
        }


class UpdateUserModel(BaseModel):
    fullname: Optional[str]
    email: Optional[EmailStr]
    phone: Optional[float]

    class Config:
        schema_extra = {
            "example": {
                "fullname": "John Does",
                "email": "john@does.com",
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