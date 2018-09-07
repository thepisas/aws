if [ $# -ne 2 ];then
  echo -e "usage: ${BASH_SOURCE[0]} stack_name_prefix env"
  echo -e "e.g ${BASH_SOURCE[0]} amzecr-posrf-bucketstorageapi dev"
  exit 1
fi
stack_name=${1}-${2}
env=${2}
IamUserName=svc_ecr_push_posrf_${env}
RepositoryName=amzecr_posrf_${env}/bucketstorageapi
cmd="aws cloudformation create-stack --stack-name ${stack_name}  --template-body file://./ECR.template.json --enable-termination-protection --parameters ParameterKey=IamUserName,ParameterValue=${IamUserName} ParameterKey=RepositoryName,ParameterValue=${RepositoryName}"
echo "${cmd}"
#echo -n "If you want to execute the above command hit ENTER"
#read input
eval $cmd
