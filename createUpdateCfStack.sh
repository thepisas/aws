if [ $# -ne 5 ];then
  echo -e "usage: ${BASH_SOURCE[0]} stack_name cfn_template_file parameter_file Application operation"
  echo -e "e.g ${BASH_SOURCE[0]} RStudioDev ec2.cfn.json RStudio.par RStudio create"
  exit 1
fi
stack_name=${1}
cfn_template_file=${2}
parameter_dir="."
parameter_file="${3}"
Application=${4}
operation=${5}
if [ ${operation} = 'create' ]; then
	cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} --parameters file://${parameter_dir}/${parameter_file} --capabilities CAPABILITY_NAMED_IAM --timeout-in-minutes 8 --tags Key=Application,Value=${Application}"
elif [ ${operation} = 'update' ]; then
	cmd="aws cloudformation update-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file} --parameters file://${parameter_dir}/${parameter_file} --capabilities CAPABILITY_NAMED_IAM"
else 
	echo "Invalid value entered for operation ... exiting" ; exit 1
fi
echo "${cmd}"
#echo -n "If you want to execute the above command hit ENTER"
#read input
eval $cmd
