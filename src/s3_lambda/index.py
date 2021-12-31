import os
import logging
import boto3
import some_layer_file_1 as cf
import another_layer_2 as l2

LOGGER = logging.getLogger()
LOGGER.setLevel(logging.INFO)

BUCKET_ARN = os.environ.get("S3_BUCKET_ARN")
BUCKET_ARN = os.environ.get("IAM_ROLE_ARN")


def lambda_handler(event, context):
    print("Ok, works")

    cf.my_func_1()

    l2.init_second_class()
