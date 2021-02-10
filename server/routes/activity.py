from fastapi import APIRouter, Body
from fastapi.encoders import jsonable_encoder


from server.database.helpers.activity import (
    add_activity,
    delete_activity,
    retrieve_activity,
    retrieve_activities,
)
from server.models.activity import (
    ErrorResponseModel,
    ResponseModel,
    ActivitySchema,
)

router = APIRouter()

# activity routes


# GET all activities
@router.get("/", response_description="activities retrieved")
async def get_activities():
    activities = await retrieve_activities()
    if activities:
        return ResponseModel(activities, "activities data retrieved successfully")
    return ResponseModel(activities, "Empty list returned")


# GET an activity
@router.get("/{id}", response_description="activity data retrieved")
async def get_activity_data(id):
    activity = await retrieve_activity(id)
    if activity:
        return ResponseModel(activity, "activity data retrieved successfully")
    return ErrorResponseModel("An error occurred.", 404, "activity doesn't exist.")


# CREATE a activity
@router.post("/", response_description="activity data added into the database")
async def add_activity_data(activity: ActivitySchema = Body(...)):
    activity = jsonable_encoder(activity)
    new_activity = await add_activity(activity)
    return ResponseModel(new_activity, "activity added successfully.")


# DELETE an activity
@router.delete("/{id}", response_description="activity data deleted from the database")
async def delete_activity_data(id: str):
    deleted_activity = await delete_activity(id)
    if deleted_activity:
        return ResponseModel(
            "activity with ID: {} removed".format(
                id), "activity deleted successfully"
        )
    return ErrorResponseModel(
        "An error occurred", 404, "activity with id {0} doesn't exist".format(
            id)
    )
