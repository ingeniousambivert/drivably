from server.database.models.user_model import ResponseModel
from server.database.models.services_model import EmailModel
from fastapi import APIRouter
from fastapi_mail import FastMail, MessageSchema
from server.utils.email.config import email_config
from server.utils.email import template

router = APIRouter()


# Send Email
@router.post("/email", response_description="Email Sent",)
async def send_email(email: EmailModel):

    message = MessageSchema(
        subject="Test",
        # List of recipients, as many as you can pass
        recipients=email.dict().get("email"),
        body="html",
        subtype="html"
    )

    send_mail = FastMail(email_config)
    await send_mail.send_message(message)
    return ResponseModel("Email sent successfully")
