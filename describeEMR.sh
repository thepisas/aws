#!/bin/bash
# displays information about all rds_instances

if [ $# -ne 1 ];then
  echo -e "usage: . $0 <mfa_code_from_your_device>"
  exit 1
fi

mfa_code=${1}
output_dir=../output
#replaces listString.sh or describeString.sh to String.csv
output_file=${output_dir}/`echo "${BASH_SOURCE[0]}"|perl -p -i -e 's~.*(list|describe)(.*)\.sh~$2.csv~'` #${BASH_SOURCE[0]} gives the script name ; it works when the script is invoked as  "source ./script.sh" and  as ./script.sh ; $0 works only when invoked as ./script.sh

#unset the temp credentials (variables) set by MFA.sh during a previous run ; if not when you call MFA.sh,   the "aws sts get-session-token" call will be invoked with  your temp credentials  that was set by a previous run of MFA.sh , as oppossed to your permanent AWS cred and thus will error out  with "An error occurred (AccessDenied) when calling the GetSessionToken operation: Cannot call GetSessionToken with session credentials"
source ./unsetTempCred.sh

#get and set temporary credentials when MFA is in use ; this by default expires in 12 hours
source ../MFA.sh ${mfa_code}  


echo '"Cluster Name","Number of Nodes","Node Type",VpcId,AvailabilityZone,EnhancedVpcRouting,Encryption,Endpoint,Roles,Environment' > ${output_file}
#aws redshift describe-clusters | jq -r '.Clusters[]|[.ClusterIdentifier,.NumberOfNodes,.NodeType,.VpcId,.AvailabilityZone,.EnhancedVpcRouting,.Encrypted,.Endpoint.Address+" , port: "+(.Endpoint.Port|tostring) +" , dbname: "+.DBName,.IamRoles[0].IamRoleArn + " , " + .IamRoles[1].IamRoleArn] |@csv'| sort -b -k1 >> ${output_file}
for i in `aws emr list-clusters --output text --query 'Clusters[0].Id'` ; do aws emr describe-cluster --cluster-id $i|jq -r '.Cluster.Name,.Cluster.InstanceGroups[].InstanceGroupType,.Cluster.InstanceGroups[].EbsBlockDevices[].VolumeSpecification.SizeInGB,.Cluster.InstanceGroups[].InstanceType,.Cluster.MasterPublicDnsName'; done
echo "The output is in ${output_file}"