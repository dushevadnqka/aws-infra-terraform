import os
import logging
import boto3

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

BUCKET_ARN = os.environ.get("S3_BUCKET_ARN")
BUCKET_ARN = os.environ.get("IAM_ROLE_ARN")


def lambda_handler(event, context):
    print("Ok, works")
