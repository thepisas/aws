#replaces way with day, but not away
perl -p -i -e 's~(?<!a)way~day~g' ./*.sh
