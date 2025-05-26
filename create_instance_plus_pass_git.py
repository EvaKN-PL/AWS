import boto3
import time
from base64 import b64decode
from Crypto.Cipher import PKCS1_v1_5
from Crypto.PublicKey import RSA

AMI_ID = 'number_ami'   # change this for your
INSTANCE_TYPE = 'type'
KEY_NAME = 'name_key_pair'
PRIVATE_KEY_PATH = 'path_to_key_pair'
SUBNET_ID = 'subnet_number'
SECURITY_GROUP_ID = 'number_of_sg'


session = boto3.Session()
region = session.region_name

print(f'Region: {region}')

session = boto3.Session(region_name=region)
ec2 = session.resource('ec2', region_name=region)
ec2_client = ec2.meta.client

# Create instance

instances = ec2.create_instances(
    ImageId=AMI_ID,
    MinCount=1,
    MaxCount=1,
    InstanceType=INSTANCE_TYPE,
    KeyName=KEY_NAME,
    NetworkInterfaces=[
        {
            'DeviceIndex': 0,
            'AssociatePublicIpAddress': True,  # or False if you don`t need
            'SubnetId': SUBNET_ID,
            'Groups': [SECURITY_GROUP_ID]  # LIST-important

        }
    ]
)
for instance in instances:
    instance.wait_until_running()
    instance.reload()
    print(f'Instance is ready: {instance.id}')
    print(f'Public ID: {instance.public_ip_address}')

# password

print('waiting for the opportunity to generate a password...')
while True:
    password_data = ec2.meta.client.get_password_data(InstanceId=instance.id)
    if password_data['PasswordData']:
        break
    time.sleep(10)

# Download encrypted password

encrypted_password = password_data['PasswordData']

with open(PRIVATE_KEY_PATH, 'r') as key:
    private_key = key.read()


key_Windows = RSA.importKey(private_key)
cipher = PKCS1_v1_5.new(key_Windows)
decrypt_password = cipher.decrypt(b64decode(encrypted_password), None)

print(f'Password for Administrator: {decrypt_password.decode()}')
