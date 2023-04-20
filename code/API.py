import requests

url = "https://ij92qpvpma.execute-api.eu-west-1.amazonaws.com/candidate-email_serverless_lambda_stage/data"
headers = {"X-Siemens-Auth": "test"}
payload = {
    "subnet_id": "<Your Private Subnet ID>",
    "name": "<Your Full Name>",
    "email": "<Your Email Address>"
}

response = requests.post(url, headers=headers, json=payload)

print(response.status_code)
print(response.text)

