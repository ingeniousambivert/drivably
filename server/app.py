from fastapi import FastAPI
from server.routes.user import router as UserRouter
from server.routes.car import router as CarRouter
from server.routes.bac import router as BacRouter
from server.routes.activity import router as ActivityRouter
from server.routes.casualty import router as CasualtyRouter


app = FastAPI()

app.include_router(UserRouter, tags=["User"], prefix="/user")
app.include_router(CarRouter, tags=["Car"], prefix="/car")
app.include_router(BacRouter, tags=["Car"], prefix="/bac")
app.include_router(ActivityRouter, tags=["Car"], prefix="/activity")
app.include_router(CasualtyRouter, tags=["Car"], prefix="/casualty")


@ app.get("/", tags=["Root"])
async def read_root():
    return "Welcome to the Drivably API!"
