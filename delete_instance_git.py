import boto3
from botocore.exceptions import ClientError

INSTANCE_ID = 'id your instance'
REGION = 'region'

ec2 = boto3.client('ec2', region_name=REGION)

try:
    response_desc = ec2.describe_instances(InstanceIds=[INSTANCE_ID])
    state = response_desc['Reservations'][0]['Instances'][0]['State']['Name']
    print(f'State of instance before terminated: {state}')

    if state == 'terminated':
        print(f'Instance: {INSTANCE_ID} is already terminated')
    else:
        response = ec2.terminate_instances(InstanceIds=[INSTANCE_ID])
        for instance in response['TerminatingInstances']:
            print(
                f"Instance {instance['InstanceId']} is now moving to state: {instance['CurrentState']['Name']}")

except ClientError as e:
    if 'InvalidInstanceID.NotFound' in str(e):
        print(f'Instance {INSTANCE_ID} does not exist')
    else:
        print(f'Unexpected error: {e}')
