launch-template-id=${2}
aws ec2 delete-launch-template --launch-template-id "$2" --region us-east-1
