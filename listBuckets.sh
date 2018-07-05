#!/bin/bash
source ./MFA.sh ${1} #get temporary credentials when MFA is in use
aws s3 ls

#Optionally unset the credentials set by MFA.sh in the exported environment variables in that script; if not the next time you call MFA.sh, the call aws sts get-session-token  will use your temp credentails as oppossed to your permanent cred and thus will error out 
#source ./unsetTempCred.sh
