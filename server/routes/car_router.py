from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder
from server.utils.helpers import check_car_exists


from server.database.controllers.car_controller import (
    add_car,
    delete_car,
    retrieve_car,
    retrieve_cars,
    update_car,
)
from server.database.models.car_model import (
    ErrorResponseModel,
    ResponseModel,
    CarSchema,
    UpdateCarModel,
)

router = APIRouter()


# GET all cars
@router.get("/", response_description="cars retrieved")
async def get_cars():
    cars = await retrieve_cars()
    if cars:
        return ResponseModel(cars, "cars data retrieved successfully")
    return ResponseModel(cars, "Empty list returned")


# GET a car
@router.get("/{id}", response_description="car data retrieved")
async def get_car_data(id):
    car = await retrieve_car(id)
    if car:
        return ResponseModel(car, "car data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "car doesn't exist.")


# CREATE a car
@router.post("/", response_description="car data added into the database")
async def add_car_data(car: CarSchema = Body(...)):
    car_exists = await check_car_exists(car.car_license)

    if not car_exists:
        car = jsonable_encoder(car)
        new_car = await add_car(car)
        return ResponseModel(new_car, "car added successfully.")

    return ErrorResponseModel("Conflict", 409, "Car already exists")


# UPDATE a car
@router.put("/{id}", response_description="car data updated")
async def update_car_data(id: str, data: UpdateCarModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_car = await update_car(id, data)
    if updated_car:
        return ResponseModel(
            "car with ID: {} updated successfully".format(id),
            "car updated successfully",
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the car data.",
    )


# DELETE a car
@router.delete("/{id}", response_description="car data deleted from the database")
async def delete_car_data(id: str):
    deleted_car = await delete_car(id)
    if deleted_car:
        return ResponseModel(
            "car with ID: {} removed".format(id), "car deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "car with id {0} doesn't exist".format(id)
    )
