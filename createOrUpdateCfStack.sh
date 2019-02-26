if [ $# -ne 5 ];then
  echo -e "usage: ${BASH_SOURCE[0]} stack_name cfn_template_file parameter_file Application operation"
  echo -e "e.g ${BASH_SOURCE[0]} RStudioDev RStudio.cfn.json RStudioDev.par RStudio create"
  echo -e "e.g ${BASH_SOURCE[0]} RStudioProd RStudio.cfn.json RStudioProd.par RStudio update"
  echo -e "e.g ${BASH_SOURCE[0]} MontyCloudTeamDev MontyCloudTeam.cfn.json none staging-build create"
  echo -e "e.g ${BASH_SOURCE[0]} MontyCloudTeamDev MontyCloudTeam.cfn.yaml none staging-build update"
  echo -e "e.g ${BASH_SOURCE[0]} Poc ec2.cfn.json ec2.par poc create"
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
operation=${5}
if [ ${operation} = 'create' ]; then
	cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} ${parameters} --capabilities CAPABILITY_NAMED_IAM --timeout-in-minutes 15 --tags Key=Application,Value=${Application} --enable-termination-protection"
elif [ ${operation} = 'update' ]; then
	cmd="aws cloudformation update-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} ${parameters} --capabilities CAPABILITY_NAMED_IAM"
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
