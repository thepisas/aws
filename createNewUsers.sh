for i in jvanderw jnarayan schugh pcrosta tshaffer ; do useradd -m -G ssh_access $i ; passwd $i ; passwd -e $i ; done
