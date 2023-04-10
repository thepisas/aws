#!/usr/bin/env bash
source ParameterFile.txt
aws ssm put-parameter --name $RDSMySQLParameterStoreName --type "String" --value $RDSMySQLPassword --profile $AWS_PROFILE
aws ssm put-parameter --name $RDSOracleParameterStoreName --type "String" --value $RDSOraclePassword --profile $AWS_PROFILE
aws ssm put-parameter --name $RDSRedshiftParameterStoreName --type "String" --value $RDSRedshiftPassword --profile $AWS_PROFILE
aws ssm put-parameter --name $ELSLambdaUserNameParameterStore --type "String" --value $ELSLambdaUserNameParameterStoreValue --profile $AWS_PROFILE
aws ssm put-parameter --name $ELSLambdaUserPasswordParameterStore --type "String" --value $ELSLambdaUserPasswordParameterStoreValue --profile $AWS_PROFILE
aws ssm put-parameter --name $ELSDefaultUserPswdParameterStore --type "String" --value $ELSDefaultUserPswdParameterStoreValue --profile $AWS_PROFILE
aws ssm put-parameter --name $ELSLDAPBindParameterStore --type "String" --value $ELSLDAPBindPswdParameterStoreValue --profile $AWS_PROFILE
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
