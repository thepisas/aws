#!/usr/bin/perl -w
#script to replace  Multi-line string in a file with somethingelse
#$*=1;  #this turns on  multi-line matching for this file, as well as any sub-routine that this script may call; so its not good and is deprecated; so I used the "//m"  and "//s" in the substitution line

$numArgs=$#ARGV + 1;
if ($numArgs!=1) {
   print "usage: perl $0 <inputfile> \ne.g.: perl $0 impdp_books.par.bk\n";
   exit 1 ;
}

#foreach $argnum (0 .. $#ARGV) {
#   print "$ARGV[$argnum]\n";
#}

#read from inputfile passed in as a command line argument
open(INPUT_FILE,"<$ARGV[0]") or die;
@input_array=<INPUT_FILE>;
close(INPUT_FILE);
$input_scalar=join("",@input_array);

###### substitution done here.######

#$search_regex='STORAGE\([^\)]+\)[\n]*';
#$search_regex='STORAGE\(.+\n.*DEFAULT\)\n';
#$search_regex='(ALTER TABLE[^\.].+\."([^"]+)"[ ]+ADD)([ ]+PRIMARY KEY)';
#AMI	ami-0e524e75
#Application	RStudio
print ($input_scalar);
#$search_regex='(.*?)\s+(\S+)\n';
$search_regex='\"';
#$replace_str='';  #note: if the string to be replaced contains $1 $2 etc., they are replaced literally as $1 and $2 instead of the grouping that you want want; it doesn't seem that there's a work around for this

# '%' is used as delimiters ; $1 represent first grouping, $2 represents 2nd grouping, the final 'm' is needed to do multiline matching
#$input_scalar =~ s%(TABLES=\(sb\.(.+)\)\nquery=)%$1$2:%m;
#$input_scalar =~ s%(TABLES=\(sb\.(.+)\).*query=)%$1$2:%s; #same effect as above ; note . by default matches any char other than \n , but 's' at the end modifes that behavior to have . match \n as well

#$input_scalar =~ s%$search_regex%$1 CONSTRAINT $2_PK$3%g; 
#$input_scalar =~ s%$search_regex%{\n  \"ParameterKey\": \"$1\",\n  \"ParameterValue\": \"$2\"\n},\n%g; 
#replace " with \"
#replace " with \"
$input_scalar =~s%\"%\\"%g; 
#$input_scalar =~ s%$search_regex%$replace_str%g; 
#$input_scalar =~ s%$search_regex%$replace_str%sg; #same effect as above ; note . by default matches any char other than \n , but 's' at the end modifes that behavior to have . match \n as well

#print ($input_scalar);
#write to the same file
open(OUTPUT,">$ARGV[0]") or die;
print(OUTPUT $input_scalar);
close(OUTPUT);
