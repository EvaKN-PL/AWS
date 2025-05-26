#!/bin/bash


AMI_ID="ami_number"
INSTANCE_TYPE="type"
VPC_ID="vpc_number"
SECURITY_GROUP_NAME="security_group_name"
REGION="region(for ex.eu-central-1)"
KEY_NAME="name_of_key_pair_file"
SUBNET_ID="subnet_number"


# Checking if SG exists

SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filters Name=group-name,Values=$SECURITY_GROUP_NAME Name=vpc-id,Values=$VPC_ID  --query 'SecurityGroups[0].GroupId' --output text --region $REGION)

#Creating a group if it doesn't exist
if [ "$SECURITY_GROUP_ID" = "None" ]; then
    echo "Tworzę nową Security Group: $SECURITY_GROUP_NAME"

    SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name $SECURITY_GROUP_NAME --description "SG2 dla Windows Server" --vpc-id $VPC_ID --query 'GroupId' --output text --region $REGION)

    echo "Security Group created: $SECURITY_GROUP_ID"
else
    echo "Security Group exist: $SECURITY_GROUP_ID"
fi

#create instance EC2

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --associate-public-ip-address \
  --query 'Instances[0].InstanceId' \
  --output text --region $REGION)

echo "Instance created. ID:$INSTANCE_ID"

