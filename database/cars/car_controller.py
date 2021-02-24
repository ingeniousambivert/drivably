from datetime import datetime
from database.aggregation.pipelines import aggregate_match_car
from server.services.cars.helpers.car_helper import cars_collection, car_helper


# Retrieve all cars present in the database
async def retrieve_cars():
    cars = []
    async for car in cars_collection.find():
        cars.append(car_helper(car))
    return cars


# Add a new car into to the database
async def add_car(car_data: dict) -> dict:
    car_data.update({"created_at": datetime.now()})
    car = await cars_collection.insert_one(car_data)
    new_car = await cars_collection.find_one({"_id": car.inserted_id})
    return car_helper(new_car)


# Retrieve a car with a matching license_number
async def retrieve_car(license_number: str) -> dict:
    car = await cars_collection.find_one({"car_license": license_number})
    if car:
        return car_helper(car)


# Update a car with a matching license_number
async def update_car(license_number: str, car_data: dict):
    # Return false if an empty request body is sent.
    if len(car_data) < 1:
        return False

    car = await cars_collection.find_one({"car_license": license_number})

    if car:
        car_data.update({"updated_at": datetime.now()})
        updated_car = await cars_collection.update_one(
            {"car_license": license_number}, {"$set": car_data}
        )
        if updated_car:
            return True
        return False


# Update ARRAY ATTRIBUTES of a car with a matching license_number
async def update_car_array_attributes(license_number: str, car_attribute: str, car_attribute_data: dict):

    car = await cars_collection.find_one({"car_license": license_number})

    if car:
        car_attribute_data["created_at"] = datetime.now()
        updated_car_attribute = await cars_collection.update_one(
            {"car_license": license_number}, {
                "$push": {car_attribute: car_attribute_data}, }
        )
        if updated_car_attribute:
            return True
        return False


# Add car driver
async def add_car_driver(license_number: str, car_driver: str):

    car = await cars_collection.find_one({"car_license": license_number})

    if car:
        updated_car_ = await cars_collection.update_one(
            {"car_license": license_number}, {
                "$push": {"drivers_email": car_driver}, }
        )
        if updated_car_:
            return True
        return False


# Remove car driver
async def remove_car_driver(license_number: str, car_driver: str):

    car = await cars_collection.find_one({"car_license": license_number})

    if car:
        updated_car_ = await cars_collection.update_one(
            {"car_license": license_number}, {
                "$pull": {"drivers_email": car_driver}, }
        )
        if updated_car_:
            return True
        return False


# Delete a car from the database
async def delete_car(license_number: str):
    car = await cars_collection.find_one({"car_license": license_number})
    if car:
        await cars_collection.delete_one({"car_license": license_number})
        return True


# Retrieve a car with a matching license_number
async def retrieve_car_owner(license_number: str):
    car_owner = await aggregate_match_car(license_number)
    return car_owner
