#!/usr/bin/env bash
function MY_MATH(){
	local A=$1
	local OP=$2
	local	B=$3
	echo $(expr $A "$OP" $B)
	}
GREEN='\033[32m'
RED='\033[31m'
RESET='\033[0m'
ERROR="Please do not drink before typing the expression."
while true;
do
echo -e $RESET"Enter expression: "
read input
reg='(-?[0-9]+)([\+*\/-])([0-9]+)'
if [[ $input =~ $reg ]];
then
echo -e $GREEN"ANSWER: "$(MY_MATH ${BASH_REMATCH[1]} "${BASH_REMATCH[2]}" ${BASH_REMATCH[3]})
else
echo -e $RED$ERROR
fi
echo ""
done