from utils.config import (AUTH_USERNAME, AUTH_PASSWORD)
from routes.user_routes import authenticate_user


auth_data = {
    "username": AUTH_USERNAME,
    "password": AUTH_PASSWORD
}


authenticate_user(auth_data)
