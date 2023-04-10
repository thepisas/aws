###EC2 - Begin##################################
Value=RedHatLinux; cmd="aws ec2 create-tags --resources \$i --tags Key=OS,Value=$Value" 
for i in i-073861006d7f7c1ed i-0f3ae2cae4a63df29 ; do 
  echo ${cmd} 
  #${cmd}
done

###EC2 - End##################################

###ECS - Begin##################################
#if using MFA , call source ../MFA.sh <token> to set the credentials needed in the commands below
aws ecs list-clusters

aws ecs list-container-instances --cluster ecs-dev #cluster-name

#to get info about container ec2 instances
aws ecs describe-container-instances --cluster ecs-dev --container-instances <arn_of_ec2_instance which you can get from the command above>

aws ecs list-task-definition-families
aws ecs list-task-definitions
aws ecs describe-task-definition --task-definition ktdev-app #task-name, by default provides the latest version

aws ecs list-services --cluster ecs-dev #cluster-name

aws ecs update-service --cluster ecs-something --service my-http-service --task-definition amazon-ecs-sample

#ECR
aws ecr get-login
aws ecr describe-repositories
aws ecr list-images --repository-name amzecsrfdev/bucketstorageapi
###ECS- End##################################

#create aws account alias
aws iam list-account-aliases
aws iam create-account-alias --account-alias tco-nonproduction

#list rules in a security group
aws ec2 describe-security-groups --filters Name=ip-permission.group-id,Values=*sg-024fb892a45248f98* --group-ids sg-6bc22d14
aws ec2 describe-security-groups --filters Name=ip-permission.group-id,Values=*sg-024fb892a45248f98* --group-ids sg-6bc22d14 --output table 

#S3
#to copy bdm software from one of the bdm instances to S3 . It took about 75 seconds to copy the 8.1 G file below
[apathros@amzbdmrfqa01 software]$ date; aws s3 cp /app/software/1011_Server_Installer_linux-x64.tar.gz s3://amzs3edhcloudformationtemplate/bdm/software ; date  | tee ~apathros/s3_copy.out
aws s3 cp /app/software/Tiffany_and_Company_MultiOS_BDM_Advanced_v1011_0129427_172729.key s3://amzs3edhcloudformationtemplate/bdm/software/license/nonprod/
aws s3 cp /app/ctmagent.tgz s3://amzs3edhcloudformationtemplate/controlm/software/
aws s3 cp s3://amzs3edhcloudformationtemplate/controlm/software/ctmagent.tgz /app/
date; aws s3 cp /app/software/1011_Server_Installer_linux-x64.tar.gz s3://tiffany-edh-environment-build-prerequisites/bdm/software ; date  

aws ssm put-parameter --name "KT_RDSStgPassword" --type "SecureString" --value "<EnterPassword>" --key-id "cdfba6b2-28bb-46c7-8e93-6ef9966da7e2" --profile "<EnterProfile>" --region "us-east-1"

