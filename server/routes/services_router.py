from server.database.models.user_model import (
    ResponseModel, ErrorResponseModel)
from fastapi import APIRouter
from fastapi_mail import (FastMail, MessageSchema, ConnectionConfig)
from pydantic import EmailStr
from typing import List
from server.utils.config import configured
from server.utils.template import email_template


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

message_text: str = "This is a test of the template"


# Send Email
@router.post("/email", response_description="Email Sent")
async def send_email(email_address: List[EmailStr]):

    message = MessageSchema(
        subject="Drivably Notifier",
        # List of recipients
        recipients=email_address,
        body=email_template(message_text),
        subtype="html"
    )

    send_mail = FastMail(email_config)

    if send_mail:
        await send_mail.send_message(message)
        return ResponseModel("Email sent successfully")

    return ErrorResponseModel("Server Error", 500, "Could not send email")
