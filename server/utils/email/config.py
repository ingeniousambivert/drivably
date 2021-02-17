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
