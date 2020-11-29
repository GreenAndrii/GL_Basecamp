#!/usr/bin/env bash
source vars.conf
expression="
-0.8/-0.9
-0.8-0.9
-0.8+0.9
-0.8/-0.9
-.8*-.9
-.8/-.9
-.8-.9
-.8+.9
5*6.3
23.5/5.02
12.32*700.2525
15.1/10.725
5.0*-12.0
(6+10-4)/(1+1*2)+1
"
for test in ${expression}; do
  result1=$(./calculator.sh ${test})
  result2=$(echo ${test} | bc -l)
	if [[ "$result1" =~ $REG_NUMBER && "$result2" =~ $REG_NUMBER ]]; then
	  result="$GREEN  EQUAL  $RESET" 
  else 
    result="$RED   VARIOS  $RESET" 
	fi
  echo -e "My result: "${result1} "\t\tSample: $YELLOW ${result2} $RESET \t\t$result" 
done
