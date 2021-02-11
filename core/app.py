from fastapi import FastAPI

from server.routes.user_router import router as UserRouter
from server.routes.car_router import router as CarRouter
from server.routes.bac_router import router as BacRouter
from server.routes.activity_router import router as ActivityRouter
from server.routes.casualty_router import router as CasualtyRouter

app = FastAPI()

app.include_router(UserRouter, tags=["User"], prefix="/user")
app.include_router(CarRouter, tags=["Car"], prefix="/car")
app.include_router(BacRouter, tags=["Blood Alcohol Content"], prefix="/bac")
app.include_router(ActivityRouter, tags=["Activity"], prefix="/activity")
app.include_router(CasualtyRouter, tags=["Casualty"], prefix="/casualty")


@app.get("/", tags=["Root"])
async def read_root():
    return "Welcome to the FastAPI Server for Drivably!"
