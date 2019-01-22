#!/bin/bash

set_debug(){
#exec 5> >(logger -t $0)
#BASH_XTRACEFD="5"
PS4='$LINENO: '
set -x -v
}

#set_debug

# Join domain script, will install neccessary packages

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FQDN=$(hostname -f)
#IP4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
IP4=$(hostname -i | awk '{print $NF}')
verbose=0
trialrun=0
DBG=""
force=0

#TGTDOM="TIFFCO.NET"
TGTDOM="Amazon.tiffco.net"
#TGTOU="OU=Linux Servers,OU=Corporate,DC=tiffco,DC=net"
TGTOU="OU=Linux,OU=servers,OU=Corporate,DC=Amazon,DC=tiffco,DC=net"
DOMUSER=""
DOMPASS=""

usage="$(basename "$0") [options] -- join host to domain

where :
        -?           This help screen
        -v              verbose (i.e. display variables)
        -t              trial run (no changes)
        -f              force (leave domain if required)
        -d arg          set active directory domain (default $TGTDOM)
        -o arg          provide target OU (default \"$TGTOU\")
        -u arg          provide username to add host (required)
        -p arg          provide password to log in (optional)
        -e arg          provide environment. Allowed values are nonprod|prod (required)
        -h arg          location of home directory. Eg. home|app (required)

"

while getopts "?vtfd:o:u:p:e:h:" opt; do
    case "$opt" in
    \?)
        echo "$usage"
        exit 0
        ;;
    v)  verbose=1
        ;;
    t)  trialrun=1
        DBG="echo "
        ;;
    f)  force=1
        ;;
    d)  TGTDOM=$OPTARG
        ;;
    o)  TGTOU=$OPTARG
        ;;
    u)  DOMUSER=$OPTARG
        ;;
    p)  DOMPASS=$OPTARG
        ;;
    e)  ENV=$OPTARG
        ;;
    h)  HOME_DIR=$OPTARG
        ;;
    esac
done

if [ $verbose -eq 1 ]; then
    echo -e "Current parameters : "
    echo -e "\tTGTDOM  = $TGTDOM"
    echo -e "\tTGTOU   = $TGTOU"
    echo -e "\tDOMUSER = $DOMUSER"
    echo -e "\tDOMPASS = $DOMPASS"
    echo -e "\tFQDN    = $FQDN"
    echo -e "\tforce   = $force"
    echo -e "\tENV     = $ENV"
    echo -e "\tHOME_DIR    = $HOME_DIR"
    echo -e "----------------------------"
fi


#check the value input for ENV
if [[ ("$ENV" != "nonprod" && "$ENV" != "prod") ]] ; then
  echo "Invalid value of $ENV entered for environment. Valid values are either nonprod or prod. Exiting ..."
  exit 1
fi


# Check if root
[ "$EUID" != "0" ] && exit 4


echo -e "\nUpdate resolv.conf to point to the Domain Controllers (which also serve as the DNS server)  in Amazon.tiffco.net namely, 10.192.15.11 and 10.192.16.11, as shown below"
echo -e "\n##############################################################"
echo -e "search ec2.internal Amazon.tiffco.net\nnameserver 10.192.15.11\nnameserver 10.192.16.11\nnameserver <IP address of the default aws nameserver> that was originally in /etc/resolv.conf"
echo "##############################################################"
echo -n -e "\nHave you updated /etc/resolv.conf with the entries above  [y/n]\n"
read input
if [ "${input}" != "y" ] && [ "${input}" != "Y" ];then
  echo -e "Exiting ... please update /etc/resolv.conf \n"
  exit 1
fi


# check if already joined
if [ -f /etc/sssd/sssd.conf ]; then
   if [ $(grep -c ${TGTDOM} /etc/sssd/sssd.conf) -ge 1 ] ; then
       echo "ALREADY JOINED"
       if [ $force -eq 0 ] ; then
           [ $trialrun -eq 0 ] && exit
       fi
   fi
fi

# Check if DOMUSER is set
if [ "x$DOMUSER" = "x" ] ; then
  echo "Set username to domain account (without @${TGTDOM}) as follows: \"$(basename "$0") -u domainaccount\""
  exit 3
fi

# Install yum packages
#${DBG}yum -y install sssd realmd krb5-workstation oddjob oddjob-mkhomedir samba-common-tools cifs-utils

# Leave Domain if forced
if [ $force -eq 1 ]; then
   ${DBG}cp -v /etc/sssd/sssd.conf /etc/sssd/sssd.conf.orig
   ${DBG}realm leave
fi

# add hostname (for DDNS)
if [ $trialrun -eq 0 ]; then
    if [ $(grep -ce "^${IP4}.*$(hostname -s)" /etc/hosts) -ge 1 ]; then
        sed -i "/^${IP4}.*$(hostname -s)/ c\\${IP4}   $(hostname -f) $(hostname -s)" /etc/hosts
    else
        cp -p /etc/hosts /etc/hosts.orig
        echo -e "${IP4}   $(hostname -f) $(hostname -s)" >> /etc/hosts
    fi
else
    echo -e "${IP4}   $(hostname -f) $(hostname -s) >> /etc/hosts"
fi

# Join tiffco.net and add to Linux OU
if [ "x$DOMPASS" = "x" ] ; then
  ${DBG}realm join -U $DOMUSER $TGTDOM --verbose --computer-ou="$TGTOU"
else
  echo "$DOMPASS" | ${DBG}realm join -U $DOMUSER $TGTDOM --verbose --computer-ou="$TGTOU"
fi

# end early if trial run
[ $trialrun -eq 1 ] && exit

#end early if not domain joined
if [ -f /etc/sssd/sssd.conf ]; then
    [ $(grep -c "\[domain/${TGTDOM}\]" /etc/sssd/sssd.conf) -eq 0 ] && exit
else
    exit
fi

# Edit sssd.conf
cat << EOF > /etc/sssd/sssd.conf
[sssd]
domains = ${TGTDOM}
config_file_version = 2
services = nss, pam

[domain/${TGTDOM}]
ad_domain = ${TGTDOM}
krb5_realm = ${TGTDOM^^}
realmd_tags = manages-system joined-with-samba
cache_credentials = True
id_provider = ad
krb5_store_password_if_offline = True
default_shell = /bin/bash
ldap_id_mapping = True
use_fully_qualified_names = False
fallback_homedir = /$HOME_DIR/%d/%u
access_provider = ad
ad_access_filter = (|(memberOf=CN=linux_admin,OU=Groups,OU=Corporate,DC=Amazon,DC=tiffco,DC=net)(memberOf=CN=linux_rstudio_$ENV,OU=Groups,OU=Corporate,DC=Amazon,DC=tiffco,DC=net)(memberOf=CN=rstudio-user,OU=Groups,OU=Corporate,DC=Amazon,DC=tiffco,DC=net)(memberOf=CN=rstudio-superuser-admin,OU=Groups,OU=Corporate,DC=Amazon,DC=tiffco,DC=net))
#ad_server = 10.192.15.11
#ad_server_backup = 10.192.16.11
EOF


if [ $force -eq 1 ] && [ -f /etc/sssd/sssd.conf.ORIG ] ; then
   mv -v /etc/sssd/sssd.conf /etc/sssd/sssd.conf.NEW
   mv -v /etc/sssd/sssd.conf.ORIG /etc/sssd/sssd.conf
fi

chown 0.0 /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

systemctl restart sssd.service

sudoers_setup () {
# copy sudoers file for tcladmins
cat << EOF > /tmp/tcladmins
%${TGTDOM}\\\\linux_admin ALL=(root) NOPASSWD: ALL
EOF
visudo -c -f /tmp/tcladmins
if [ "$?" -eq "0" ]; then
    cp -v /tmp/tcladmins /etc/sudoers.d/
fi
rm /tmp/tcladmins

chown root:root /etc/sudoers.d/tcladmins
chmod 0440 /etc/sudoers.d/tcladmins
}

#sudoers_setup

# Please reboot
echo optionally reboot the server

