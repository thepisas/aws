#code to launch ec2 instances associated with elastic search/kibana . I used this script to scale out the elastic search clusters
if [ $# -ne 10 ];then
  echo -e "usage:  $0 <environment> <node> <ebsvolume_delete_on_termination> <instance_type> <hostname> <enable_instance_termination_protection?> <root_vol_size> <app_vol_size> <availability_zone> <userdata_static_content_file>"
  echo -e "usage:  $0 dev bdm|ela-master|els-data true|false m5.4xlarge poc-amzlinelad04|amzlinelap04 yes|no 100 250 us-east-1b userDataElasticSearch.static"
  echo -e "usage:  $0 qa ela-data true m5.large poc-amzlinelaq04 no 100 50 us-east-1b userDataElasticSearch.static"
  echo -e "usage:  $0 qa ela-data false m5.4xlarge amzlinelaq04 yes 100 200 us-east-1b userDataElasticSearch.static"
  echo -e "usage:  $0 prod ela-data false m5.4xlarge amzlinelap04|amzlinelap05|amzlinelap06 yes 128 250 us-east-1b userDataElasticSearch.static"
  exit 1
fi

environment=${1}
node=${2}
software=${node%-*}  #remove everything after - in $node ; e.g. if node=els-master, then software will be els
Software=`echo ${software} |sed 's/.*/\u&/g'`  #converts to camelcase 
ebs_delete_on_termination=${3}
instance_type=${4}
hostname=${5}
instance_termination_protection=${6}
root_vol_size=${7}
app_vol_size=${8}
availability_zone=${9}
userdata_static_content_file=${10}

app=rf
App=`echo ${app} |sed 's/.*/\u&/g'`  #converts to camelcase 
tag_application=${app^^}  #convert to uppercase

instance_initiated_shutdown_behavior=stop  #default 
OS=RedHatLinux
daily_snapshot=True
monitoring=false
placement="--placement Tenancy=default,AvailabilityZone=${availability_zone}"
userdata_file="./${userdata_static_content_file%.*}.complete"

validate_input () {
if [ "${instance_termination_protection}" = "yes" ]; then 
	api_termination=--disable-api-termination
elif [ "${instance_termination_protection}" = "no" ]; then 
	api_termination=--enable-api-termination
else 
	echo "Invalid value entered for instance_termination_protection . It must be either yes or no.  Exiting ..."
	exit 1
fi
}

validate_input

case "$environment" in
    'dev')
    env=dev 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
		tag_environment=${Env}
    subnet_id=subnet-0bad1c26
		aws_account_number=869052972610
		kms_key_id=cfbe4cbe-de97-4600-8d8a-7a96066acd0f
    ;;
    'qa')
    env=qa 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
		tag_environment=${environment^^}
    subnet_id=subnet-34febe19
		aws_account_number=869052972610
		kms_key_id=cfbe4cbe-de97-4600-8d8a-7a96066acd0f
    ;;
    'prod')
    env=prod 
    Env=`echo ${env} |sed 's/.*/\u&/g'`  #converts to camelcase 
		tag_environment=${Env}
    subnet_id=subnet-78063b55
		aws_account_number=276654360894
		kms_key_id=1eed6cf9-a52a-479d-9aa5-308378d1a8a2
    ;;
esac

if [ "${software}" = "bdm" ];then
   if [ "${env}" = "dev" ];then
      key_name=EDH-TCO-INF
			image_id=ami-0ea49c4d86d419bb4
			security_group_ids="sg-b503cac9 sg-8b0e84f7 sg-07ed537a sg-9a579ce5"
   elif [ "${env}" = "qa" ];then
      key_name=EDH-TCO-INF-QA
			image_id=ami-0ea49c4d86d419bb4
			security_group_ids="sg-b503cac9 sg-8b0e84f7 sg-07ed537a sg-9a579ce5"
   fi
   block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=${root_vol_size},VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={VolumeSize=${app_vol_size},VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdc,Ebs={VolumeSize=1600,VolumeType=st1,DeleteOnTermination=${ebs_delete_on_termination},Encrypted=True,KmsKeyId=\"arn:aws:kms:us-east-1:${aws_account_number}:key/${kms_key_id}\"}'"
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${tag_environment}},{Key=Application,Value=${tag_application}},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}}]'" 
   iam_instance_profile_name=Ec2${Software}${App}${Env}Role
elif [ "${software}" = "els" ] || [ "${software}" = "kib" ] || [ "${software}" = "ela" ] ;then
   if [ "${environment}" = "dev" ];then
      security_group_ids="sg-67889f17 sg-9a579ce5"
			key_name="ELASTIC${env^^}"
			image_id=ami-0e524e75
			iam_instance_profile_name=elasticsearch${environment}_role
			svc_account=svc_esdev
   elif [ "${environment}" = "qa" ];then
      security_group_ids="sg-fc911f8f sg-9a579ce5"
			key_name="ELASTIC${env^^}"
			image_id=ami-0e524e75
			iam_instance_profile_name=elasticsearch${environment}_role
			svc_account=svc_esdev
   elif [ "${environment}" = "prod" ];then
      security_group_ids="sg-79c2340e sg-b62be9c9"
			key_name="ELASTIC${env^^}"
			image_id=ami-d59aa3af
			iam_instance_profile_name=TCO_ElasticSearch_Prod
			svc_account=svc_esprod
   fi

	 block_device_mappings="'DeviceName=/dev/sda1,Ebs={VolumeSize=${root_vol_size},VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdf,Ebs={VolumeSize=${app_vol_size},VolumeType=gp2,DeleteOnTermination=${ebs_delete_on_termination},Encrypted=True,KmsKeyId=\"arn:aws:kms:us-east-1:${aws_account_number}:key/${kms_key_id}\"}'"
	 #note: this writes tags to both ec2 instance and all the ebs volumes attached to it. ON all the ebs volumes this writes a tag Key=Name with Value=hostname, post creation , edit that tag to add the mount point it,  such as amzlinelap03 /root ,  amzlinelap03 /app 
   tag_specifications="'ResourceType=instance,Tags=[{Key=Name,Value=${hostname}},{Key=Environment,Value=${tag_environment}},{Key=Application,Value=${tag_application}},{Key=Userlogin,Value=Yes},{Key=OS,Value=${OS}},{Key=Daily-Snapshot,Value=${daily_snapshot}},{Key=clustername,Value=elasticsearch-${environment}}]' 'ResourceType=volume,Tags=[{Key=Application,Value=${tag_application}},{Key=Name,Value=${hostname}}]'" 
else 
   echo "Invalid value entered for software ... exiting"
   exit 1
fi

append_sudo_rules () {

	echo -e "\necho -e \"\\\n# Access to $svc_account,elasticsearch accounts\" >> /etc/sudoers" >> ${userdata_file}
	es_user_list=apathros
	for i in adatta viksingh nirchoud ; do
		es_user_list="$es_user_list,$i"
	done
	echo -e "echo -e \"$es_user_list  ALL=($svc_account,elasticsearch)  ALL\" >> /etc/sudoers" >> ${userdata_file}
	elevated_priv_list=$es_user_list
	echo -e "\necho -e \"\\\n# Access to administer elasticsearch service\" >> /etc/sudoers" >> ${userdata_file}
	echo -e "echo -e \"$elevated_priv_list  ALL=(root) /usr/bin/systemctl daemon-reload, /usr/bin/systemctl start elasticsearch.service, /usr/bin/systemctl stop elasticsearch.service,  /usr/bin/systemctl status elasticsearch.service, /usr/share/elasticsearch/bin/elasticsearch-plugin, /usr/share/elasticsearch/bin/x-pack/certgen\" >> /etc/sudoers" >> ${userdata_file}
}

append_to_userdata_file () {
	#append dynamic content to userdata file

	app_device_mountpoint="/app"
	app_device_expected="nvme1n1"

	remove='*amzlin'
	device_label=${hostname#$remove}-${app_device_mountpoint#/}

	rm -f ${userdata_file}
	cp ./${userdata_static_content_file} ${userdata_file}

	echo -e "#create service account and group" >> ${userdata_file}
	echo -e "groupadd -g 3000 $svc_account" >> ${userdata_file}
	echo -e "useradd -u 3000 -g 3000 $svc_account" >> ${userdata_file}
	echo -e "chage -I -1 -m 0 -M 99999 -E -1 $svc_account" >> ${userdata_file}

	append_sudo_rules

	echo -e "\n#operations pertaining to the ${app_device_mountpoint} filesystem " >> ${userdata_file}
	echo -e "mkdir ${app_device_mountpoint}" >> ${userdata_file}

	echo -e "\napp_device=\`lsblk | awk '{print \$1}'| tail -1\`" >> ${userdata_file}
	echo -e "\nif [ \"\${app_device}\" = \"${app_device_expected}\" ]; then" >> ${userdata_file}
		if [ "${environment}" != "prod" ];then
			fs=xfs
			echo -e "	mkfs.$fs /dev/\${app_device}" >> ${userdata_file}
			echo -e "	xfs_admin -L \"$device_label\" /dev/\${app_device}" >> ${userdata_file}
		else 
			#prod es nodes use ext4
			fs=ext4
			echo -e "	mkfs.$fs /dev/\${app_device}" >> ${userdata_file}
			echo -e "	e2label /dev/\${app_device} $device_label" >> ${userdata_file}
		fi
	echo -e "	immutable=\`lsattr /etc/fstab | awk -F- '{print \$5}'\`" >> ${userdata_file}
	echo -e "	if [ \"\$immutable\" = \"i\" ]; then chattr -i /etc/fstab ; fi" >> ${userdata_file}
	echo -e "	lsattr /etc/fstab" >> ${userdata_file}
	echo -e "	echo \"LABEL=$device_label ${app_device_mountpoint} $fs noatime,rw 1 2\" >> /etc/fstab" >> ${userdata_file}
	echo -e "	mount -a" >> ${userdata_file}
	echo -e "	chown -R elasticsearch.$svc_account ${app_device_mountpoint}" >> ${userdata_file}
	echo -e "	ls -ld ${app_device_mountpoint}" >> ${userdata_file}
	echo -e "	df -h ${app_device_mountpoint}" >> ${userdata_file}
	echo -e "else" >> ${userdata_file} 
	echo "	echo -e \"The app device/volume is \${app_device} when the expected value was ${app_device_expected}. So the filesystem and label were not created on it.\"" >> ${userdata_file}
	echo "fi" >> ${userdata_file}

	echo -e "\n# *********NOTE:Enable password based Authentication***********" >> ${userdata_file}
	echo -e "#update PasswordAuthentication from No to Yes in /etc/ssh/sshd_config and then restart sshd using systemctl restart sshd" >> ${userdata_file}
	echo -e "\nreboot" >> ${userdata_file}

	echo -n -e "\nWould you like to see the contents of userdata in ${userdata_file} [y/n]\n"
	read input
	if [ "${input}" = "y" ] || [ "${input}" = "Y" ];then
		echo -e "BEGIN ############################################"
		echo -e "Contents of ${userdata_file}"
		echo -e "---------------------------------------"
		cat ${userdata_file}
		echo -e "END ############################################"
	fi

	echo -e "\nThe label for the device mounted on ${app_device_mountpoint} is ${device_label}"
	echo -n -e "\nThe device that will be formatted and mounted on ${app_device_mountpoint} is /dev/${app_device_expected}. You will lose all existing content on /dev/${app_device_expected} if any. Do you want to proceed [y/n]\n"
	read i
	if [ "${i}" = "y" ] || [ "${i}" = "Y" ];then
		echo
	else 
		echo -e "Aborting ...\n"
		exit 1
	fi
}

append_to_userdata_file

cmd="aws ec2 run-instances --image-id ${image_id} --key-name ${key_name} --iam-instance-profile Name=${iam_instance_profile_name} --subnet-id ${subnet_id} --tag-specifications ${tag_specifications} ${api_termination} --instance-initiated-shutdown-behavior ${instance_initiated_shutdown_behavior} --monitoring Enabled=${monitoring} --instance-type=${instance_type} ${placement} --security-group-ids ${security_group_ids} --ebs-optimized --block-device-mappings ${block_device_mappings} --user-data file://${userdata_file}" 

echo -e "\n${cmd}"
echo -n -e "\nWould you like to execute the above command? [y/n]\n"
read input
if [ "${input}" = "y" ] || [ "${input}" = "Y" ];then
	echo -e "Executing the above command ..."
	eval $cmd
else 
	echo -e "Exiting without executing the above command.\n"
	exit 1
fi
