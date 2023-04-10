#dev
aws elbv2 create-listener --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:869052972610:loadbalancer/app/amzalb-ecs-posrf-dev/f68a4001ff9f965a \
--protocol HTTP --port 80  \
--default-actions Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-east-1:869052972610:targetgroup/amztg-ecs-posrf-dev/7bc33365cc0df36b

#qa
aws elbv2 create-listener --load-balancer-arn arn:aws:elasticloadbalancing:us-east-1:869052972610:loadbalancer/app/amzalb-ecs-posrf-qa/298670024faf0b67 \
--protocol HTTP --port 80  \
--default-actions Type=forward,TargetGroupArn=arn:aws:elasticloadbalancing:us-east-1:869052972610:targetgroup/amztg-ecs-posrf-qa/ca8bb4388334ca0b
