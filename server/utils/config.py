from typing import Optional
from pydantic import BaseSettings


class AppConfig(BaseSettings):

    openapi_url: str = "/openapi.json"

    MAIL_USERNAME: Optional[str]
    MAIL_PASSWORD: Optional[str]
    MAIL_FROM: Optional[str]
    MAIL_PORT: Optional[int]
    MAIL_SERVER: Optional[str]
    MONGO_URI: Optional[str]
    JWT_SECRET: Optional[str]
    JWT_ALGORITHM: Optional[str]

    class Config:
        env_file: str = ".env"


configured = AppConfig()
