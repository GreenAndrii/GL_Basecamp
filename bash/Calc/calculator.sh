#!/usr/bin/env bash
source vars.conf 
source my_math.sh
[[ $1 =~ ^(--help|-h)$ || -z $1 ]] && help && exit 0
input=$(echo "$*" | tr -d '[:space:]') # delete all spaces
if [[ ! $input =~ $REG_ERROR ]] && [[ $input  =~ $REG_POL ]];
	then
		echo -e $GREEN"$(exp_to_rpn $1)"$RESET
		exit 0
	else
		echo -e $RED$ERROR$RESET
		help
		exit 128
fi
