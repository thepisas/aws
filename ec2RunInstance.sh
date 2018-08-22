if [ $# -ne 5 ];then
  echo -e "usage:  $0 <environment> <key> <software> <ebs_delete_on_termination> <instance_type>"
  echo -e "usage:  $0 dev apathros bdm|els-master true|false m5.2xlarge"
  exit 1
fi

environment=${1}
key_name=${2}
node=${3}
software=${node%-*}  #remove everything after - in $node ; e.g. if node=els-master, then software will be els
Software=`echo ${software} |sed 's/.*/\u&/g'`  #converts to camelcase 
ebs_delete_on_termination=${4}
instance_type=${5}

app=rf
#App=`echo ${app} |sed 's/[^ ]\+/\L\u&/g'`  #converts to camelcase ; strictly speaking you don't need \L here
App=`echo ${app} |sed 's/.*/\u&/g'`  #converts to camelcase 
instance_termination_protection=--disable-api-termination
instance_initiated_shutdown_behavior=stop  #default 
OS=RedHatLinux
daily_snapshot=True
monitoring=false
placement="--placement Tenancy=default,AvailabilityZone=us-east-1b"

case "$environment" in
    'dev')
    env=dev 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
    subnet_id=subnet-0bad1c26
    #iam_instance_profile_name=EC2_S3Access
    ;;
    'qa')
    env=qa 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
    subnet_id=subnet-34febe19
    #iam_instance_profile_name=AMZLINEDHQ01_S3_Access
    ;;
    'prod')
    env=pr 
    ;;
esac

hostname=poc-amz${software}${app}${env}01

if [ "${software}" = "bdm" ];then
   #image_id=ami-fd2d3082
   image_id=ami-0fa2a2cb82b898c4b
   security_group_ids="sg-b503cac9 sg-8b0e84f7 sg-07ed537a sg-9a579ce5"
   block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=128,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=500,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}'"
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}}]'" 
   iam_instance_profile_name=Ec2${Software}${App}${Env}Role
elif [ "${software}" = "els" ] || [ "${software}" = "kib" ];then
   image_id=ami-0e524e75
   security_group_ids="sg-67889f17 sg-9a579ce5"
   if [ "${node}" = "els-slave" ];then
       block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}'"
   else  #elastic master and kibana node
       block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=50,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}'"
   fi
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${app}2},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}},{Key=clustername,Value=elasticsearch${app}-${env}}]'" 
   #key_name=ELASTICDEV
   iam_instance_profile_name=Ec2Els${App}${Env}Role
else 
   echo "Invalid value entered for software ... exiting"
   exit 1
fi

#iam_instance_profile_name=Ec2${Software}${App}${Env}Role

cmd="aws ec2 run-instances --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --tag-specifications ${tag_specifications} ${instance_termination_protection} --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior} --monitoring Enabled=${monitoring} --instance-type=${instance_type} ${placement} --security-group-ids ${security_group_ids} --ebs-optimized --block-device-mappings ${block_device_mappings}" 

echo "${cmd}"
eval $cmd
