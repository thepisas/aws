ebs_delete_on_termination=false
block_device_mappings="'DeviceName=/dev/sda1,Ebs={DeleteOnTermination=${ebs_delete_on_termination}}','DeviceName=/dev/sdb,Ebs={DeleteOnTermination=${ebs_delete_on_termination}}'"
aws ec2 modify-instance-attribute --instance-id i-01f1d11a95 --block-device-mappings ${block_device_mappings}

or you could do the following
aws ec2 modify-instance-attribute --instance-id i-01f1d11a953-block-device-mappings file://mapping.json
cat mapping.json
[
{
"DeviceName": "/dev/sdb",
"Ebs": {
"DeleteOnTermination": false
}
}
]

