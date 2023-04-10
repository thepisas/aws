if [ $# -ne 7 ];then
  echo -e "usage: ${BASH_SOURCE[0]} stack_name cfn_template_file parameter_file Application Environment operation timeout_in_minutes"
  echo -e "e.g ${BASH_SOURCE[0]} RStudioDev RStudio.cfn.json RStudioDev.par RStudio stg create 15"
  echo -e "e.g ${BASH_SOURCE[0]} RStudioProd RStudio.cfn.json RStudioProd.par RStudio dev update  15"
  echo -e "e.g ${BASH_SOURCE[0]} MontyCloudTeamDev MontyCloudTeam.cfn.json none staging-build stg create 15"
  echo -e "e.g ${BASH_SOURCE[0]} MontyCloudTeamDev MontyCloudTeam.cfn.yaml none staging-build stg update 15"
  exit 1
fi
stack_name=${1}
cfn_template_file=${2}
parameter_dir="."
parameter_file="${3}"

if [ ${parameter_file} = 'none' ]; then
 parameters=""
else 
 parameters="--parameters file://${parameter_dir}/${parameter_file}"
fi


Application=${4}
Environment=${5}
operation=${6}
timeout_in_minutes=${7}

if [ ${operation} = 'create' ]; then
	cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} ${parameters} --capabilities CAPABILITY_NAMED_IAM --timeout-in-minutes ${timeout_in_minutes} --tags Key=Application,Value=${Application} Key=Environment,Value=${Environment} --enable-termination-protection"
elif [ ${operation} = 'update' ]; then
	cmd="aws cloudformation update-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} ${parameters} --capabilities CAPABILITY_NAMED_IAM --tags Key=Application,Value=${Application},Value=${Environment}"
else 
	echo "Invalid value entered for operation ... exiting" ; exit 1
fi

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
