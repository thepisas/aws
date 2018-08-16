template_name=$1
aws ec2 delete-launch-template --launch-template-name ${template_name}
