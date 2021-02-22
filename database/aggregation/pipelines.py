async def aggregate_lookup_owner(collection, **pipeline):
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
        {
            "$project": {
                "owner_data._id": 0
            }
        },
    ]

    async for doc in collection.aggregate(pipeline):
        data.append(doc)

    return data


async def aggregate_match_owner(collection, email):
    data = []
    pipeline = [
        {
            "$project": {"_id": 0}
        },
        {
            "$match": {"owner_email": email}
        },
    ]

    async for doc in collection.aggregate(pipeline):
        data.append(doc)

    return data
