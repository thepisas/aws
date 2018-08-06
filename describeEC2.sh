#!/bin/bash
# displays information about all ec2_instances

if [ $# -ne 2 ];then
  echo -e "usage: . ${BASH_SOURCE[0]} <mfa_code_from_your_device> <profile>"
  return 1 #using return here , instead of exit as the appropriate invocation of this script is "source ${BASH_SOURCE[0]} or . ${BASH_SOURCE[0]}" . Doing so causes the script to be executed in the current shell (instead of in another spawned shell) ; thereby the variables(temporary credentials) set in ../MFA.sh are available to you even in your current shell even after this script has ended. So after executing this script, from the same shell prompt you can subsequently run other aws commands withouth having to set the temporary credentials again. If you don't use source  (or .) , and instead simply execute this script as ${BASH_SOURCE[0]} , then a new shell will be spawned and this script will be run in that shell and so the variables set are not available to you after the script has ended .  Getting back to using return vs exit here , since  a new shell is not spawned when you use . , if you use exit here, you will lose your terminal . Normally return is used to return from a function, but in this use case, you use it to return from the executing script .
fi

mfa_code=${1}
profile=${2}
output_dir=../output
#output_file=${output_dir}/ec2.csv
#replaces listString.sh or describeString.sh to String.csv
output_file=${output_dir}/${profile}_`echo "${BASH_SOURCE[0]}"|perl -p -e 's~.*(list|describe)(.*)\.sh~$2.csv~'` #${BASH_SOURCE[0]} gives the script name ; it works when the script is invoked as  "source ./script.sh" and  as ./script.sh ; $0 works only when invoked as ./script.sh

#unset the temp credentials (variables) set by MFA.sh during a previous run ; if not when you call MFA.sh,   the "aws sts get-session-token" call will be invoked with  your temp credentials  that was set by a previous run of MFA.sh , as oppossed to your permanent AWS cred and thus will error out  with "An error occurred (AccessDenied) when calling the GetSessionToken operation: Cannot call GetSessionToken with session credentials"
source ./unsetTempCred.sh

#get and set temporary credentials when MFA is in use ; this by default expires in 12 hours
source ../MFA.sh ${mfa_code} ${profile} 


#aws ec2 describe-instances --output text --query 'Reservations[*].Instances[*].[InstanceId, InstanceType,State.Name, LaunchTime, Placement.AvailabilityZone, Placement.Tenancy, PrivateIpAddress, PrivateDnsName, PublicDnsName, [Tags[?Key==`Name`].Value] [0][0], [Tags[?Key==`purpose`].Value] [0][0], [Tags[?Key==`environment`].Value] [0][0], [Tags[?Key==`team`].Value] [0][0] ]' > instances.csv
#aws ec2 describe-instances --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, PublicDnsName, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' > instances.json
echo "Name,InstanceId,InstanceType,AvailabilityZone,PrivateIpAddress,OperatingSystem,Tag,Environment,State" > ${output_file}
#aws ec2 describe-instances --output text  --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' | sed -e 's/\t/,/g' | sort -t, -k7 -k8 -k6 -k1  >> ${output_file}
#echo "aws ec2 describe-instances --profile ${profile} --output text  --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' | sed -e 's/\t/,/g' | sort -t, -k7 -k8 -k6 -k1  >> ${output_file}"
#aws ec2 describe-instances --profile ${profile} --output text  --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' | sed -e 's/\t/,/g' | sort -t, -k7 -k8 -k6 -k1  >> ${output_file}
aws ec2 describe-instances  --output text  --query 'Reservations[*].Instances[*].[[Tags[?Key==`Name`].Value] [0][0],InstanceId, InstanceType,Placement.AvailabilityZone,PrivateIpAddress, [Tags[?Key==`OS`].Value] [0][0],[Tags[?Key==`Application`].Value] [0][0],[Tags[?Key==`Environment`].Value] [0][0],State.Name]' | sed -e 's/\t/,/g' | sort -t, -k7 -k8 -k6 -k1  >> ${output_file}

echo "The output is in ${output_file}"
