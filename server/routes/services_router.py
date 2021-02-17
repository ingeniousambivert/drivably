from server.database.models.user_model import (
    ResponseModel, ErrorResponseModel)
from fastapi import APIRouter
from fastapi_mail import FastMail, MessageSchema
from pydantic import EmailStr
from typing import List

from fastapi_mail import ConnectionConfig
from server.utils.config import configured


email_config = ConnectionConfig(
    MAIL_USERNAME=configured.MAIL_USERNAME,
    MAIL_PASSWORD=configured.MAIL_PASSWORD,
    MAIL_FROM=configured.MAIL_FROM,
    MAIL_PORT=configured.MAIL_PORT,
    MAIL_SERVER=configured.MAIL_SERVER,
    MAIL_TLS=True,
    MAIL_SSL=False,
    USE_CREDENTIALS=True
)


router = APIRouter()

template: str = "<p>This is a test</p>"


# Send Email
@router.post("/email", response_description="Email Sent",)
async def send_email(email_address: List[EmailStr]):

    message = MessageSchema(
        subject="Test",
        # List of recipients
        recipients=email_address,
        body=template,
        subtype="html"
    )

    send_mail = FastMail(email_config)
    mail_sent = await send_mail.send_message(message)

    if mail_sent:
        return ResponseModel("Email sent successfully")
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error sending the email.",
    )
