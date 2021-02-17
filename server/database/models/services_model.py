from pydantic import BaseModel, EmailStr
from typing import List


class EmailModel(BaseModel):
    email: List[EmailStr]
