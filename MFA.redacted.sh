#MFA_ARN is redacted here 

#!/bin/bash

source ~/awscli/aws/unsetTempCred.sh

if [ $# -ne 2 ];then
  echo -e "usage: . ${BASH_SOURCE[0]} <mfa_code_from_your_device> <profile>"
  return 1 #using return here , instead of exit as the appropriate invocation of this script is "source ${BASH_SOURCE[0]} or . ${BASH_SOURCE[0]}" . Doing so causes the script to be executed in the current shell (instead of in another spawned shell) ; thereby the variables(temporary credentials) set in ../MFA.sh are available to you even in your current shell even after this script has ended. So after executing this script, from the same shell prompt you can subsequently run other aws commands withouth having to set the temporary credentials again. If you don't use source  (or .) , and instead simply execute this script as ${BASH_SOURCE[0]} , then a new shell will be spawned and this script will be run in that shell and so the variables set are not available to you after the script has ended .  Getting back to using return vs exit here , since  a new shell is not spawned when you use . , if you use exit here, you will lose your terminal . Normally return is used to return from a function, but in this use case, you use it to return from the executing script .
  #echo -e "usage: $0 <mfa_code_from_your_device> <profile>"
  #exit 1
fi

export MFA_TOKEN="$1"
profile="$2"

case "$2" in
    'n')
    export MFA_ARN="arn:aws:iam::8********:mfa/ap***s"
    ;;
    'p')
    export MFA_ARN="arn:aws:iam::2********:mfa/ap***s"
    ;;
    'm')
    export MFA_ARN="arn:aws:iam::9*****:mfa/ap***s"
    ;;
		*)
		echo "Invalid value, $2 ,  entered for profile . Exiting ..." 
		return 1
		;;
esac


echo $MFA_ARN
output=`aws sts get-session-token --serial-number ${MFA_ARN} --token-code ${MFA_TOKEN} --profile ${profile}` 
#the credentials returned above are valid by default for 12 hours"

#echo output is $output


export AWS_ACCESS_KEY_ID=`echo ${output}|jq -r '.Credentials.AccessKeyId'`
export AWS_SECRET_ACCESS_KEY=`echo ${output}|jq -r '.Credentials.SecretAccessKey'`
export AWS_SESSION_TOKEN=`echo ${output}|jq -r '.Credentials.SessionToken'`

cred_expiration=`echo ${output}|jq '.Credentials.Expiration'`

output_values () {
	#echo output is $output
	echo AWS_SECRET_ACCESS_KEY  is ${AWS_SECRET_ACCESS_KEY}
	echo AWS_SESSION_TOKEN is ${AWS_SESSION_TOKEN}
}

#output_values
echo credentials will expire at ${cred_expiration}

