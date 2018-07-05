#!/bin/bash
# displays information about all ec2_instances

if [ $# -ne 1 ];then
  echo -e "usage: . $0 <mfa_code_from_your_device>"
  exit 1
fi

mfa_code=${1}
output_dir=../output

#unset the temp credentials (variables) set by MFA.sh during a previous run ; if not when you call MFA.sh,   the "aws sts get-session-token" call will be invoked with  your temp credentials  that was set by a previous run of MFA.sh , as oppossed to your permanent AWS cred and thus will error out  with "An error occurred (AccessDenied) when calling the GetSessionToken operation: Cannot call GetSessionToken with session credentials"
source ./unsetTempCred.sh

#get and set temporary credentials when MFA is in use ; this by default expires in 12 hours
source ../MFA.sh ${mfa_code}  

output_file=${output_dir}/ec2.csv

#aws ec2 describe-instances --output text --query 'Reservations[*].Instances[*].[InstanceId, InstanceType,State.Name, LaunchTime, Placement.AvailabilityZone, Placement.Tenancy, PrivateIpAddress, PrivateDnsName, PublicDnsName, [Tags[?Key==`Name`].Value] [0][0], [Tags[?Key==`purpose`].Value] [0][0], [Tags[?Key==`environment`].Value] [0][0], [Tags[?Key==`team`].Value] [0][0] ]' > instances.csv
#aws ec2 describe-instances --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, PublicDnsName, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' > instances.json
echo "Name,InstanceId,InstanceType,AvailabilityZone,PrivateIpAddress,OperatingSystem,Tag,Environment,State" > ${output_file}
aws ec2 describe-instances --output text  --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' | sed -e 's/\t/,/g' | sort -t, -k7 -k8 -k6 -k1  >> ${output_file}

echo "The output is in ${output_file}"
