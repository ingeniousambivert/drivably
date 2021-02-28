from fastapi import APIRouter, Body, status
from typing import Dict
from fastapi.encoders import jsonable_encoder
from server.utils.helpers import check_car_exists


from database.cars.car_controller import (
    add_car,
    delete_car,
    retrieve_car,
    retrieve_cars,
    update_car,
    add_car_driver,
    remove_car_driver,
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
        return ResponseModel(cars, status.HTTP_200_OK, "Successfully retrieved cars")
    return ResponseModel("Empty list returned")


# GET a car
@router.get("/{license}", response_description="car data retrieved")
async def get_car_data(license_number: str):
    car = await retrieve_car(license_number)
    if car:
        return ResponseModel(car, status.HTTP_200_OK, "Successfully retrieved car with license: " + license_number)
    return ErrorResponseModel("An error occurred.", status.HTTP_404_NOT_FOUND, "car doesn't exist.")


# GET a car's owner data
@router.get("/owner/", response_description="car's owner data retrieved")
async def get_owner_data(license_number: str):
    car_owner = await retrieve_car_owner(license_number)
    if car_owner:
        return ResponseModel(car_owner, status.HTTP_200_OK, "Successfully retrieved car's owner data")
    return ErrorResponseModel("An error occurred.", status.HTTP_404_NOT_FOUND, "car owner doesn't exist.")


# CREATE a car
@router.post("/", response_description="car data added into the database")
async def add_car_data(car: CarSchema = Body(...)):
    car_exists = await check_car_exists(car.car_license)

    if not car_exists:
        car = jsonable_encoder(car)
        new_car = await add_car(car)
        if new_car:
            return ResponseModel(new_car, status.HTTP_201_CREATED, "Successfully registered new car")
        return ErrorResponseModel(
            "An error occurred",
            status.HTTP_500_INTERNAL_SERVER_ERROR,
            "Could not register car",
        )

    return ErrorResponseModel("Conflict", status.HTTP_409_CONFLICT, "Car already registered")


# UPDATE a car
@router.put("/{license}", response_description="car data updated")
async def update_car_data(license_number: str, data: UpdateCarModel = Body(...)):
    data = {key: value for key, value in data.dict().items()
            if value is not None}
    updated_car = await update_car(license_number, data)
    if updated_car:
        return ResponseModel("Updated", status.HTTP_200_OK,
                             "Successfully updated car with license: " + license_number
                             )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_404_NOT_FOUND,
        "There was an error updating the car data.",
    )


# Add a car's drivers
@router.put("/driver/{license}", response_description="car driver added")
async def add_car_driver_data(license_number: str, car_driver: str):

    updated_car = await add_car_driver(license_number, car_driver)
    if updated_car:
        return ResponseModel("Updated", status.HTTP_200_OK,
                             "Successfully added driver: " +
                             car_driver + " to car: " + license_number
                             )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_404_NOT_FOUND,
        "There was an error updating the car data.",
    )


# UPDATE a car's attributes
@router.put("/attribute/{license}", response_description="car attribute updated")
async def update_car_attributes(license_number: str, car_attribute: str, car_attribute_data: Dict = Body(...)):
    car_attribute_data = {key: value for key, value in car_attribute_data.items()
                          if value is not None}
    updated_car_attribute = await update_car_array_attributes(license_number, car_attribute, car_attribute_data)
    if updated_car_attribute:
        return ResponseModel("Updated", status.HTTP_200_OK,
                             "Successfully updated car attribute: " +
                             car_attribute + " with license: " + license_number
                             )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_404_NOT_FOUND,
        "There was an error updating the car data.",
    )


# Delete a car's drivers
@router.delete("/driver/{license}", response_description="car driver deleted")
async def remove_car_driver_data(license_number: str, car_driver: str):

    updated_car = await remove_car_driver(license_number, car_driver)
    if updated_car:
        return ResponseModel("Updated", status.HTTP_200_OK,
                             "Successfully removed driver: " +
                             car_driver + " to car: " + license_number
                             )
    return ErrorResponseModel(
        "An error occurred",
        status.HTTP_404_NOT_FOUND,
        "There was an error updating the car data.",
    )


# DELETE a car
@router.delete("/{license}", response_description="car data deleted from the database")
async def delete_car_data(license_number: str):
    deleted_car = await delete_car(license_number)
    if deleted_car:
        return ResponseModel("Deleted", status.HTTP_200_OK,
                             "Successfully deleted car with license: " + license_number
                             )
    return ErrorResponseModel(
        "An error occurred",  status.HTTP_404_NOT_FOUND, "car with license: {} doesn't exist".format(
            license_number)
    )
