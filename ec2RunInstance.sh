if [ $# -ne 4 ];then
  echo -e "usage:  $0 <environment> <node> <ebsvolume_delete_on_termination> <instance_type>"
  echo -e "usage:  $0 dev bdm|els-master true|false m5.2xlarge"
  exit 1
fi

environment=${1}
node=${2}
software=${node%-*}  #remove everything after - in $node ; e.g. if node=els-master, then software will be els
Software=`echo ${software} |sed 's/.*/\u&/g'`  #converts to camelcase 
ebs_delete_on_termination=${3}
instance_type=${4}
#key_name=${5}

app=rf
#App=`echo ${app} |sed 's/[^ ]\+/\L\u&/g'`  #converts to camelcase ; strictly speaking you don't need \L here
App=`echo ${app} |sed 's/.*/\u&/g'`  #converts to camelcase 
tag_application=${app^^}2  #convert to uppercase
instance_termination_protection=--disable-api-termination
#instance_termination_protection=--enable-api-termination
instance_initiated_shutdown_behavior=stop  #default 
OS=RedHatLinux
daily_snapshot=True
monitoring=false
placement="--placement Tenancy=default,AvailabilityZone=us-east-1b"
user_data="./userData"

case "$environment" in
    'dev')
    env=dev 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
    subnet_id=subnet-0bad1c26
    ;;
    'qa')
    env=qa 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
    subnet_id=subnet-34febe19
    ;;
    'prod')
    env=pr 
    ;;
esac


if [ "${software}" = "bdm" ];then
   #image_id=ami-fd2d3082
   #image_id=ami-0fa2a2cb82b898c4b
   image_id=ami-0ea49c4d86d419bb4
   if [ "${env}" = "dev" ];then
      key_name=EDH-TCO-INF
   elif [ "${env}" = "qa" ];then
      key_name=EDH-TCO-INF-QA
   fi
   security_group_ids="sg-b503cac9 sg-8b0e84f7 sg-07ed537a sg-9a579ce5"
   #block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=128,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=500,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}'"
   block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=128,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=500,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdc,Ebs={VolumeSize=1600,VolumeType=st1,DeleteOnTermination=${ebs_delete_on_termination},Encrypted=True,KmsKeyId=\"arn:aws:kms:us-east-1:869052972610:key/cfbe4cbe-de97-4600-8d8a-7a96066acd0f\"}'"
   hostname=poc-amz${software}${app}${env}01
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${tag_application}},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}}]'" 
   iam_instance_profile_name=Ec2${Software}${App}${Env}Role
elif [ "${software}" = "els" ] || [ "${software}" = "kib" ];then
   image_id=ami-0e524e75
   key_name="ELASTIC${env^^}"
   if [ "${environment}" = "dev" ];then
      security_group_ids="sg-67889f17 sg-9a579ce5"
   elif [ "${environment}" = "qa" ];then
      security_group_ids="sg-fc911f8f sg-9a579ce5"
   fi
   if [ "${node}" = "els-slave" ];then
       block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination},Encrypted=True,KmsKeyId=\"arn:aws:kms:us-east-1:869052972610:key/cfbe4cbe-de97-4600-8d8a-7a96066acd0f\"}'"
       hostname=poc-amz${software}${app}${env}02  #if you are creating multiple slave nodes, rename them 03 ,04 post creation . TODO :make this dynamic later
   else  #elastic master and kibana node
       block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=100,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=50,VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination},Encrypted=True,KmsKeyId=\"arn:aws:kms:us-east-1:869052972610:key/cfbe4cbe-de97-4600-8d8a-7a96066acd0f\"}'"
       hostname=poc-amz${software}${app}${env}01
   fi
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${environment}},{Key=Application,Value=${tag_application},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}},{Key=clustername,Value=elasticsearch${app}-${env}}]'" 
   iam_instance_profile_name=Ec2Els${App}${Env}Role
else 
   echo "Invalid value entered for software ... exiting"
   exit 1
fi

#iam_instance_profile_name=Ec2${Software}${App}${Env}Role

cmd="aws ec2 run-instances --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --tag-specifications ${tag_specifications} ${instance_termination_protection} --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior} --monitoring Enabled=${monitoring} --instance-type=${instance_type} ${placement} --security-group-ids ${security_group_ids} --ebs-optimized --block-device-mappings ${block_device_mappings} --user-data file://${user_data}" 

echo "${cmd}"
#eval $cmd
