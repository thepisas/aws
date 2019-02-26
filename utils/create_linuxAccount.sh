# This script creates a user account, sets the temporary password and forces the user to change it on next login
password=`tr -cd '[:alnum:]' < /dev/urandom | fold -w8 | head -n1`

if test "$1" = ""
then
echo "Please enter username!"
exit
fi

# Add the user
useradd $1 -G ssh_access

# Change the password
passwd $1 << EOF
$password
$password
EOF

# Set it to change on next logon
chage -d0 $1

# Output to screen
echo "Username $1"
echo "Password $password"

