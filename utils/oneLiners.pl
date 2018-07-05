#Negative look-behind example - replaces string way with day, but not the string away
perl -p -i -e 's~(?<!a)way~day~g' ./*.sh
