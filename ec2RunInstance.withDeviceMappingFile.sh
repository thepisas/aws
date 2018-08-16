if [ $# -ne 4 ];then
  echo -e "usage:  $0 <environment> <key> <software> <device_mapping_file>"
  echo -e "usage:  $0 dev apathros bdm|es bdm_device_mapping.json"
  exit 1
fi

environment=${1}
key_name=${2}
software=${3}
block_device_mapping_file=${4}

app=rf
image_id=ami-fd2d3082
instance_initiated_shutdown_behavior=stop  #default 
OS=RedHatLinux
daily_snapshot=True
monitoring=false
placement="--placement Tenancy=default,AvailabilityZone=us-east-1b"
security_group_ids="sg-b503cac9 sg-8b0e84f7 sg-07ed537a sg-9a579ce5"
instance_type=m4.2xlarge

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

hostname=poc-amzbdmrf${env}01

cmd="aws ec2 run-instances --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}}]' --disable-api-termination --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior} --monitoring Enabled=${monitoring} --instance-type=${instance_type} ${placement} --security-group-ids ${security_group_ids} --ebs-optimized --block-device-mappings file://${block_device_mapping_file}" 

echo "${cmd}"
eval $cmd
