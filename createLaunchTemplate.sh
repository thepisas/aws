#json_string=`cat ../output/launchTemplate.json`
#j=`echo $json_string`
#json_string=`echo $(cat ../output/launchTemplate.json)`
#echo "aws ec2 create-launch-template --launch-template-name poc --launch-template-data '${json_string}'"
json_file="../output/launchTemplate.json"
echo "aws ec2 create-launch-template --launch-template-name poc --cli-input-json file://${json_file}"
