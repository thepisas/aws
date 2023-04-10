#!/usr/bin/env bash
source ParameterFile.txt
# echo "Generating STS token for MFA Login using temporary credentials"
# echo "$1"
# aws sts get-session-token --duration "$DURATION" --serial-number "$ARN_OF_MFA" --token-code "$1" --profile $AWS_PROFILE --output text > output
# if [ $? -eq 0 ]; then
#     echo "Token Generated"
# else
#     echo "Token FAILED to Generated"
# fi 
# AWS_ACCESS_KEY_ID=$(awk '{print $2}' output)
# AWS_SECRET_ACCESS_KEY=$(awk '{print $4}' output)
# AWS_SESSION_TOKEN=$(awk '{print $5}' output)

# echo "Temporary credentials:"
# echo "AWS_ACCESS_KEY_ID: " $AWS_ACCESS_KEY_ID
# echo "AWS_SECRET_ACCESS_KEY: " $AWS_SECRET_ACCESS_KEY
# echo "AWS_SESSION_TOKEN: " $AWS_SESSION_TOKEN

# export  AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
# export  AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
# export  AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
# if [ $? -eq 0 ]; then
#     echo "Login Successfull"
# else
#     echo "Login FAIL"
# fi 
# aws ssm put-parameter --name $RDSMySQLParameterStoreName --type "String" --value $RDSMySQLPassword
# aws ssm put-parameter --name $RDSOracleParameterStoreName --type "String" --value $RDSOraclePassword
# aws ssm put-parameter --name $RDSRedshiftParameterStoreName --type "String" --value $RDSRedshiftPassword
aws ssm put-parameter --name $ELSLambdaUserNameParameterStore --type "String" --value $ELSLambdaUserNameParameterStoreValue --description "Username used by Lambda client to connect to Elastic Search" --profile $AWS_PROFILE --region "us-east-1"
#aws ssm put-parameter --name $ELSLambdaUserPasswordParameterStore --type "String" --value $ELSLambdaUserPasswordParameterStoreValue 
# aws ssm put-parameter --name $ELSDefaultUserPswdParameterStore --type "String" --value $ELSDefaultUserPswdParameterStoreValue
# aws ssm put-parameter --name $ELSLDAPBindParameterStore --type "String" --value $ELSLDAPBindPswdParameterStoreValue
#kmskeyId=$(aws kms create-key --query 'KeyMetadata.KeyId' --profile $AWS_PROFILE --region "us-east-1" --output text)
#echo "$kmskeyId"
if [ $? -eq 0 ]; then
    echo "KMS Key Created Successfully"
else
    echo "KMS Key FAILED to create"
fi 

#kmskeyId="cdfba6b2-28bb-46c7-8e93-6ef9966da7e2"
#aws kms create-alias --alias-name "alias/$KMSKeyAliasName" --target-key-id "$kmskeyId" --profile $AWS_PROFILE --region "us-east-1"
#aws ssm put-parameter --name $KMSKeyIDParameterStoreName --type "String" --value "$kmskeyId" --profile $AWS_PROFILE --region "us-east-1"
#aws ssm put-parameter --name $KTRDSUserNameParameterStoreName --type "SecureString" --value $KTRDSUserName --key-id "$kmskeyId" --profile $AWS_PROFILE --region "us-east-1"
#aws ssm put-parameter --name $KTRDSUserPasswordParameterStoreName --type "SecureString" --value $KTRDSUserPassword --key-id "$kmskeyId" --profile $AWS_PROFILE --region "us-east-1"
if [ $? -eq 0 ]; then
    echo "SSM Parmeter Store is created"
else
    echo "SSM Parameter FAILED to create"
fi 
# aws s3api create-bucket --bucket $EMRFilesBucketName --profile $AWS_PROFILE
# if [ $? -eq 0 ]; then
#     echo "EMR Bucket Created Successfully"
# else
#     echo "EMR Bucket FAILED to Create"
# fi 
# key=$(aws ec2 create-key-pair --key-name $KeyPairName --query 'KeyMaterial' --profile $AWS_PROFILE --output text)
# aws ssm put-parameter --name $KeyPairParameterStoreName --type "String" --value "$key" --profile $AWS_PROFILE
# aws aws iam create-policy --policy-name "DBAdmins-SSMPolicy" --policy-document file://TCO-EDH-DBAdminSSMPermissions.json --profile $AWS_PROFILE
# aws aws iam create-policy --policy-name "ESAdmins-SSMPolicy" --policy-document file://TCO-EDH-ESAdminSSMPermissions.json --profile $AWS_PROFILE
# # aws s3api put-bucket-policy --bucket $EDHPrerequisitesbucket --policy file://Bucketpolicy.json
# aws s3 cp s3://$SourceEMRBucketName/ s3://$EMRFilesBucketName/ --recursive --profile $AWS_PROFILE
