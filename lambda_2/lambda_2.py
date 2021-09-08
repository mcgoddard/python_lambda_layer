from datetime import datetime
import boto3
from common import get_parameter_name

ssm = boto3.client('ssm')

def lambda_handler(event, context):
    ssm_value = str(datetime.now())
    ssm.put_parameter(
        Name=get_parameter_name(),
        Description='Parameter for lambdas',
        Value=ssm_value,
        Type='String',
        Overwrite=True,
        Tier='Standard',
        DataType='text',
    )
    return {
        'parameter_value': ssm_value
    }