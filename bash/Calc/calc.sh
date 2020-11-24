#!/usr/bin/env bash
source vars.conf 
source my_math.sh
[[ $1 =~ (--help|-h) ]] && help && exit 0
while true;
do
echo -e $RESET"Enter expression: (or 'q' for exit)"
read input
[[ $input =~ [qQ] ]] && exit 0
if [[ $input =~ $reg ]];
then
echo -e $GREEN"ANSWER: "$(MY_MATH ${BASH_REMATCH[1]} "${BASH_REMATCH[2]}" ${BASH_REMATCH[3]})
else
echo -e $RED$ERROR
fi
echo ""
done