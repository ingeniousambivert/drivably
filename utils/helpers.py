from utils.client.redis import redisClient

access_token = redisClient.get("access_token")

auth_headers = {"Authorization": f"Bearer {access_token}"}
content_headers = {"Content-Type": "application/json"}
