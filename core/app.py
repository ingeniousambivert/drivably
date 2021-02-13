from fastapi import FastAPI, Depends
from fastapi.security import OAuth2PasswordBearer
from fastapi.middleware.cors import CORSMiddleware
from server.routes.user_router import router as UserRouter
from server.auth.auth_router import router as AuthRouter
from server.routes.car_router import router as CarRouter


oauth2_scheme = OAuth2PasswordBearer(tokenUrl='signin')
app = FastAPI()

origins = [
    "http://localhost",
    "http://localhost:8008",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(AuthRouter, tags=["Auth"])
app.include_router(UserRouter, tags=["User"],
                   prefix="/user",
                   dependencies=[Depends(oauth2_scheme)])
app.include_router(CarRouter, tags=["Car"],
                   prefix="/car",
                   dependencies=[Depends(oauth2_scheme)])


@ app.get("/", tags=["Root"])
async def read_root():
    return "Welcome to the FastAPI Server for Drivably!"
