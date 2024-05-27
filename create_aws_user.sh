#!/bin/bash

# Define variables
USER_NAME="terraform-user"
POLICY_NAME="TerraformUserPolicy"

# Create the user
aws iam create-user --user-name $USER_NAME

# Create an inline policy with the necessary permissions
cat > policy.json << EOL
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "rds:*",
                "vpc:*",
                "iam:GetUser",
                "iam:ListUsers",
                "iam:ListPolicies",
                "iam:ListPolicyVersions",
                "iam:GetPolicy",
                "iam:GetPolicyVersion",
                "iam:ListRoles",
                "iam:GetRole",
                "iam:ListRolePolicies",
                "iam:GetRolePolicy",
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}
EOL

# Attach the inline policy to the user
aws iam put-user-policy --user-name $USER_NAME --policy-name $POLICY_NAME --policy-document file://policy.json

# Create access keys for the user
ACCESS_KEYS=$(aws iam create-access-key --user-name $USER_NAME)

# Extract the Access Key ID and Secret Access Key
ACCESS_KEY_ID=$(echo $ACCESS_KEYS | jq -r '.AccessKey.AccessKeyId')
SECRET_ACCESS_KEY=$(echo $ACCESS_KEYS | jq -r '.AccessKey.SecretAccessKey')

# Output the Access Key ID and Secret Access Key
echo "Access Key ID: $ACCESS_KEY_ID"
echo "Secret Access Key: $SECRET_ACCESS_KEY"

# Clean up the policy file
rm policy.json

