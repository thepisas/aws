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

