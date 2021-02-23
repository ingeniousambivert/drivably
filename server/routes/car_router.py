from fastapi import APIRouter, Body
from typing import Dict
from fastapi.encoders import jsonable_encoder
from server.utils.helpers import check_car_exists


from database.cars.car_controller import (
    add_car,
    delete_car,
    retrieve_car,
    retrieve_cars,
    update_car,
    update_car_array_attributes,
    retrieve_car_owner
)
from server.services.cars.model.car_model import (
    ErrorResponseModel,
    ResponseModel,
    CarSchema,
    UpdateCarModel,
)

router = APIRouter()


@router.get("/", response_description="cars retrieved")
async def get_cars():
    cars = await retrieve_cars()
    if cars:
        return ResponseModel(cars, 200, "Successfully retrieved cars")
    return ResponseModel("Empty list returned")


# GET a car
@router.get("/{id}", response_description="car data retrieved")
async def get_car_data(id):
    car = await retrieve_car(id)
    if car:
        return ResponseModel(car, 200, "Successfully retrieved car with ID: " + id)
    return ErrorResponseModel("An error occurred.", 404, "car doesn't exist.")


# GET a car's owner data
@router.get("/owner/", response_description="car's owner data retrieved")
async def get_owner_data(license_number: str):
    car_owner = await retrieve_car_owner(license_number)
    if car_owner:
        return ResponseModel(car_owner, 200, "Successfully retrieved car's owner data")
    return ErrorResponseModel("An error occurred.", 404, "car owner doesn't exist.")


# CREATE a car
@router.post("/", response_description="car data added into the database")
async def add_car_data(car: CarSchema = Body(...)):
    car_exists = await check_car_exists(car.car_license)

    if not car_exists:
        car = jsonable_encoder(car)
        new_car = await add_car(car)
        return ResponseModel(new_car, 200, "Successfully registered new car")

    return ErrorResponseModel("Conflict", 409, "Car already registered")


# UPDATE a car
@router.put("/{id}", response_description="car data updated")
async def update_car_data(id: str, data: UpdateCarModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_car = await update_car(id, data)
    if updated_car:
        return ResponseModel("Updated", 200,
                             "Successfully updated car with ID: " + id
                             )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the car data.",
    )


# UPDATE a car's attributes
@router.put("/attribute/{id}", response_description="car attribute updated")
async def update_car_attributes(id: str, car_attribute: str, car_attribute_data: Dict = Body(...)):
    car_attribute_data = {key: value for key, value in car_attribute_data.items()
                          if value is not None}
    updated_car_attribute = await update_car_array_attributes(id, car_attribute, car_attribute_data)
    if updated_car_attribute:
        return ResponseModel("Updated", 200,
                             "Successfully updated car attribute: " + car_attribute + " with ID: " + id
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
        return ResponseModel("Deleted", 200,
                             "Successfully deleted car with ID: " + id
                             )
    return ErrorResponseModel(
        "An error occurred", 404, "car with id {0} doesn't exist".format(id)
    )
