if [ $# -ne 2 ];then
  echo -e "usage: ${BASH_SOURCE[0]} stack_name cfn_template_file"
  echo -e "e.g ${BASH_SOURCE[0]} poc-amzrstedhdev01 ec2.cfn.json"
  exit 1
fi
stack_name=${1}
cfn_template_file=${2}
#cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./ECR.template.json --enable-termination-protection --parameters ParameterKey=IamUserName,ParameterValue=${IamUserName} ParameterKey=RepositoryName,ParameterValue=${RepositoryName}"
cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./${cfn_template_file}"
echo "${cmd}"
#echo -n "If you want to execute the above command hit ENTER"
#read input
#eval $cmd
