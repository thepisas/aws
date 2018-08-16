if [ $# -ne 2 ];then
  #echo -e "usage:  ${BASH_SOURCE[0]} <json_file_containing_launch_settings> <template_name>"
  echo -e "usage:  ${BASH_SOURCE[0]} ../output/EC2LaunchTemplate.i-05d804aa499da9114.json.poc rf-poc"
  exit 1
fi

#json_string=`cat ../output/launchTemplate.json`
#j=`echo $json_string`
#json_string=`echo $(cat ../output/launchTemplate.json)`
#echo "aws ec2 create-launch-template --launch-template-name poc --launch-template-data '${json_string}'"
json_file="$1"
template_name="$2"
echo "aws ec2 create-launch-template --launch-template-name ${template_name} --cli-input-json file://${json_file}"
aws ec2 create-launch-template --launch-template-name ${template_name} --cli-input-json file://${json_file}
