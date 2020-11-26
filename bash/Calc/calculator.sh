#!/usr/bin/env bash
source vars.conf 
source my_math.sh
[[ $1 =~ ^(--help|-h)$ || -z $1 ]] && help && exit 0
input=$(echo $* | tr -d '[:space:]') # delete all spaces
if [[ ! $input =~ $REG_ERROR ]] && [[ $input  =~ $REG_FLOAT ]];
	then
		echo -e $GREEN"ANSWER: "$(MY_MATH_FLOAT ${BASH_REMATCH[1]} "${BASH_REMATCH[2]}" ${BASH_REMATCH[3]})
		exit 0
	else
		echo -e $RED$ERROR$RESET
		help
		exit 128
fi
