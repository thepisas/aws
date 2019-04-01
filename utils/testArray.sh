#!/bin/bash
user_accounts="HTML5,CCS3,BootStrap,JQuery"

field_separator=$IFS
 
# set comma as internal field separator for the string list
IFS=,
for i in $user_accounts; do
  echo $i
done

IFS=$field_separator
