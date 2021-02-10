from fastapi import Depends, FastAPI
from server.routes.user import router as UserRouter
from server.routes.car import router as CarRouter

app = FastAPI()

app.include_router(UserRouter, tags=["User"], prefix="/user")
app.include_router(CarRouter, tags=["Car"], prefix="/car")


@ app.get("/", tags=["Root"])
async def read_root():
    return "Welcome to the Drivably API!"
