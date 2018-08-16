if [ $# -ne 3 ];then
  echo -e "usage:  $0 <template_name> <environment> <key>"
  echo -e "usage:  $0 rf-bdm dev apathros"
  exit 1
fi

template=${1}
#template=rf-poc
#environment=dev
environment=${2}
key_name=${3}
iam_instance_profile_name=${4}

app=rf
image_id=ami-fd2d3082
instance_initiated_shutdown_behavior=stop  #default 

case "$environment" in
    'dev')
    env=d 
    subnet_id=subnet-0bad1c26
    iam_instance_profile_name=EC2_S3Access
    ;;
    'qa')
    env=q 
    subnet_id=subnet-34febe19
    iam_instance_profile_name=AMZLINEDHQ01_S3_Access
    ;;
    'prod')
    env=p 
    ;;
esac

#hostname=poc-rf-inf-${env}
hostname=poc-amzbdmrf${env}01

#cmd="aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ami-fd2d3082 --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}}]'"
#cmd="aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --disable-api-termination ${disable_api_termination} --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}}]'" 
cmd="aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}}]' --disable-api-termination --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior}" 

#aws ec2 run-instances --launch-template LaunchTemplateName=${template} 
#echo "aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ami-fd2d3082 --key-name apathros --iam-instance-profile Name=EC2_S3Access --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=poc-rf-inf},{Key=Environment,Value=Dev},{Key=Application,Value=rf}]'"
#echo "aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ami-fd2d3082 --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}}]'"
#aws ec2 run-instances --launch-template LaunchTemplateName=${template} --image-id ami-fd2d3082 --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}}]'
echo "${cmd}"
eval $cmd
