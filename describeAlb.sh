aws elbv2 describe-load-balancers --load-balancer-arns arn:aws:elasticloadbalancing:us-east-1:869052972610:loadbalancer/app/ecsrfdev/4c6266a36ef91e26
aws elbv2 describe-load-balancer-attributes --load-balancer-arn
aws elbv2 describe-target-groups --names ECSRFDEVTG
aws elbv2 describe-listeners --listener-arns arn:aws:elasticloadbalancing:us-east-1:869052972610:listener/app/ecsrfdev/4c6266a36ef91e26/a933fca31df920d8

amzalb-ecs-posrf-dev
amztg-ecs-posrf-dev
