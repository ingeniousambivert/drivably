from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder


from server.database.controllers.bac import (
    add_bac,
    delete_bac,
    retrieve_bac,
    retrieve_all_bac,
    update_bac,
)
from server.database.models.bac import (
    ErrorResponseModel,
    ResponseModel,
    BacSchema,
    UpdateBacModel,
)

router = APIRouter()

# bac routes


# GET all bac
@router.get("/", response_description="bac retrieved")
async def get_bac():
    bac = await retrieve_all_bac()
    if bac:
        return ResponseModel(bac, "bac data retrieved successfully")
    return ResponseModel(bac, "Empty list returned")


# GET a bac
@router.get("/{id}", response_description="bac data retrieved")
async def get_bac_data(id):
    bac = await retrieve_bac(id)
    if bac:
        return ResponseModel(bac, "bac data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "bac doesn't exist.")


# CREATE a bac
@router.post("/", response_description="bac data added into the database")
async def add_bac_data(bac: BacSchema = Body(...)):
    bac = jsonable_encoder(bac)
    new_bac = await add_bac(bac)
    return ResponseModel(new_bac, "bac added successfully.")


# UPDATE a bac
@router.put("/{id}")
async def update_bac_data(id: str, req: UpdateBacModel = Body(...)):
    req = {key: value for key, value in req.dict().items() if value is not None}
    updated_bac = await update_bac(id, req)
    if updated_bac:
        return ResponseModel(
            "bac with ID: {} updated successfully".format(id),
            "bac updated successfully",
        )
    return ErrorResponseModel(
        "An error occurred",
        404,
        "There was an error updating the bac data.",
    )


# DELETE a bac
@router.delete("/{id}", response_description="bac data deleted from the database")
async def delete_bac_data(id: str):
    deleted_bac = await delete_bac(id)
    if deleted_bac:
        return ResponseModel(
            "bac with ID: {} removed".format(id), "bac deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "bac with id {0} doesn't exist".format(id)
    )
