from fastapi import FastAPI, Depends

from server.routes.user_router import router as UserRouter
from server.routes.auth_router import router as AuthRouter
from server.routes.car_router import router as CarRouter
from server.routes.bac_router import router as BacRouter
from server.routes.activity_router import router as ActivityRouter
from server.routes.casualty_router import router as CasualtyRouter

from server.auth.jwt_bearer import JWTBearer

token_listener = JWTBearer()

app = FastAPI()

app.include_router(AuthRouter, tags=["Auth"])
app.include_router(UserRouter, tags=[
                   "User"], prefix="/user", dependencies=[Depends(token_listener)])
app.include_router(
    CarRouter, tags=["Car"], prefix="/car", dependencies=[Depends(token_listener)])
app.include_router(BacRouter, tags=[
                   "Blood Alcohol Content"], prefix="/bac", dependencies=[Depends(token_listener)])
app.include_router(ActivityRouter, tags=[
                   "Activity"], prefix="/activity", dependencies=[Depends(token_listener)])
app.include_router(CasualtyRouter, tags=[
                   "Casualty"], prefix="/casualty", dependencies=[Depends(token_listener)])


@app.get("/", tags=["Root"])
async def read_root():
    return "Welcome to the FastAPI Server for Drivably!"
