from server.services.cars.helpers.car_helper import cars_collection
from server.services.users.helpers.user_helper import users_collection


async def aggregate_lookup_owner(**pipeline):
    data = []
    pipeline = [
        {
            "$project": {
                "_id": 0
            }
        }, {
            "$lookup": {
                "from": pipeline["from"],
                "localField": pipeline["localField"],
                "foreignField": pipeline["foreignField"],
                "as": pipeline["as"]
            }
        },
        # {
        #     "$project": {
        #         "owner_data._id": 0
        #     }
        # },
    ]

    async for doc in users_collection.aggregate(pipeline):
        data.append(doc)

    return data


async def aggregate_match_owner(email: str):
    data = []
    pipeline = [
        {
            "$project": {"_id": 0}
        },
        {
            "$match": {"owner_email": email}
        },
    ]

    async for doc in cars_collection.aggregate(pipeline):
        data.append(doc)

    return data


async def aggregate_match_car(license_number: str):
    data = []
    pipeline = [
        {
            "$project": {"_id": 0}
        },
        {
            "$match": {"cars": license_number}
        },
    ]

    async for doc in users_collection.aggregate(pipeline):
        data.append(doc)

    return data
