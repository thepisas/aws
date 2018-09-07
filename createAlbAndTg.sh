if [ $# -ne 1 ];then
  echo -e "usage: ${BASH_SOURCE[0]} environment"
  echo -e "e.g ${BASH_SOURCE[0]} dev"
  exit 1
fi

environment=${1}
vpc_id=vpc-6057bd06

case "$environment" in
    'dev')
    env=dev 
    subnets="subnet-0bad1c26 subnet-723b5b3b"
    sg="sg-a4e844ed"
    ;;
    'qa')
    env=qa 
    subnets="subnet-34febe19 subnet-f1ceffb8"
    sg="sg-c772d48e"
    ;;
    'prod')
    env=prd 
    ;;
esac

lb_name=amzalb-ecs-posrf-${env}
tg_name=amztg-ecs-posrf-${env}

cmd1="aws elbv2 create-load-balancer --name ${lb_name} --subnets ${subnets} --security-groups ${sg} --scheme internal --type application"
echo "${cmd1}"
eval $cmd1

cmd2="aws elbv2 create-target-group --name ${tg_name} --protocol HTTP --port 80 --vpc-id ${vpc_id} --health-check-protocol HTTP --health-check-path /"
echo "${cmd2}"
eval $cmd2

