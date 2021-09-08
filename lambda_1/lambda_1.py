import boto3
from common import get_parameter_name

ssm = boto3.client('ssm')

def lambda_handler(event, context):
    response = ssm.get_parameter(
        Name=get_parameter_name(),
        WithDecryption=False,
    )
    return {
        'parameter_value': response['Parameter']['Value']
    }
