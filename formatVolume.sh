mkfs.xfs /dev/nvme1n1
xfs_admin -L "rstdev01-app" /dev/nvme1n1
LABEL=rstdev01-app /app  xfs noatime,rw 1 2
lsattr /etc/fstab
#if the output of the above has the immutability flag set  , i , then do the following to remove it
chattr -i /etc/fstab
mkdir /app

