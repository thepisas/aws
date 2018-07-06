#!/bin/bash
# displays information about all rds_instances

if [ $# -ne 1 ];then
  echo -e "usage: . ${BASH_SOURCE[0]} <mfa_code_from_your_device>"
  return 1 #using return here , instead of exit as the appropriate invocation of this script is "source ${BASH_SOURCE[0]} or . ${BASH_SOURCE[0]}" . Doing so causes the script to be executed in the current shell (instead of in another spawned shell) ; thereby the variables(temporary credentials) set in ../MFA.sh are available to you even in your current shell even after this script has ended. So after executing this script, from the same shell prompt you can subsequently run other aws commands withouth having to set the temporary credentials again. If you don't use source  (or .) , and instead simply execute this script as ${BASH_SOURCE[0]} , then a new shell will be spawned and this script will be run in that shell and so the variables set are not available to you after the script has ended .  Getting back to using return vs exit here , since  a new shell is not spawned when you use . , if you use exit here, you will lose your terminal . Normally return is used to return from a function, but in this use case, you use it to return from the executing script .
fi

mfa_code=${1}
output_dir=../output
#output_file=${output_dir}/RDS.csv
#replaces listString.sh or describeString.sh to String.csv
output_file=${output_dir}/`echo "${BASH_SOURCE[0]}"|perl -p -e 's~.*(list|describe)(.*)\.sh~$2.csv~'` #${BASH_SOURCE[0]} gives the script name ; it works when the script is invoked as  "source ./script.sh" and  as ./script.sh ; $0 works only when invoked as ./script.sh

#unset the temp credentials (variables) set by MFA.sh during a previous run ; if not when you call MFA.sh,   the "aws sts get-session-token" call will be invoked with  your temp credentials  that was set by a previous run of MFA.sh , as oppossed to your permanent AWS cred and thus will error out  with "An error occurred (AccessDenied) when calling the GetSessionToken operation: Cannot call GetSessionToken with session credentials"
source ./unsetTempCred.sh

#get and set temporary credentials when MFA is in use ; this by default expires in 12 hours
source ../MFA.sh ${mfa_code}  


echo '"Instance Identifier","DB Engine",DBInstanceClass,AllocatedStorage,Encryption,MultiAZ,Endpoint,Environment' > ${output_file}
#aws rds describe-db-instances --output text --query 'DBInstances[*].[DBInstanceIdentifier,Engine,DBInstanceClass,AllocatedStorage,StorageEncrypted,MultiAZ,Endpoint.Address,Endpoint.Port,DBName]' >> ${output_file}
aws rds describe-db-instances | jq -r '.DBInstances[] | [.DBInstanceIdentifier,.Engine,.DBInstanceClass,.AllocatedStorage,.StorageEncrypted,.MultiAZ,.Endpoint.Address +" , port: "+(.Endpoint.Port|tostring) +" , dbname: "+.DBName] |@csv' | sort -b -k1 >> ${output_file}
echo "The output is in ${output_file}"
