import boto3
import json
import os


s3 = boto3.client("s3")
dynamodb = boto3.resource("dynamodb")

BUCKET_NAME = "lambda-sample-bucket-1234"
TABLE_NAME = "lambda_sample_table"

def handler(event, context):
    try:
        s3.put_object(
            Bucket=BUCKET_NAME,
            Key="hello.txt",
            Body="Hello from Lambda (Python)!"
        )

       
        table = dynamodb.Table(TABLE_NAME)
        table.put_item(Item={"id": "1", "message": "Hello from Lambda (Python)!"})

        
        return {
            "statusCode": 200,
            "body": json.dumps("Hello World (Python) + S3 + DynamoDB!")
        }

    except Exception as e:
        
        return {
            "statusCode": 500,
            "body": json.dumps(f"Error: {str(e)}")
        }
