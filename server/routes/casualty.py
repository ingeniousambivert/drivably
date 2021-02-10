from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder


from server.database.helpers.casualty import (
    add_casualty,
    delete_casualty,
    retrieve_casualty,
    retrieve_casualties,
    update_casualty,
)
from server.models.casualty import (
    ErrorResponseModel,
    ResponseModel,
    casualtieschema,
    UpdateCasualtyModel,
)

router = APIRouter()

# casualty routes


# GET all casualties
@router.get("/", response_description="casualties retrieved")
async def get_casualties():
    casualties = await retrieve_casualties()
    if casualties:
        return ResponseModel(casualties, "casualties data retrieved successfully")
    return ResponseModel(casualties, "Empty list returned")


# GET a casualty
@router.get("/{id}", response_description="casualty data retrieved")
async def get_casualty_data(id):
    casualty = await retrieve_casualty(id)
    if casualty:
        return ResponseModel(casualty, "casualty data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "casualty doesn't exist.")


# CREATE a casualty
@router.post("/", response_description="casualty data added into the database")
async def add_casualty_data(casualty: casualtieschema = Body(...)):
    casualty = jsonable_encoder(casualty)
    new_casualty = await add_casualty(casualty)
    return ResponseModel(new_casualty, "casualty added successfully.")


# UPDATE a casualty
@router.put("/{id}")
async def update_casualty_data(id: str, req: UpdateCasualtyModel = Body(...)):
    req = {key: value for key, value in req.dict().items() if value is not None}
    updated_casualty = await update_casualty(id, req)
    if updated_casualty:
        return ResponseModel(
            "casualty with ID: {} updated successfully".format(id),
            "casualty updated successfully",
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the casualty data.",
    )


# DELETE a casualty
@router.delete("/{id}", response_description="casualty data deleted from the database")
async def delete_casualty_data(id: str):
    deleted_casualty = await delete_casualty(id)
    if deleted_casualty:
        return ResponseModel(
            "casualty with ID: {} removed".format(
                id), "casualty deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "casualty with id {0} doesn't exist".format(
            id)
    )
