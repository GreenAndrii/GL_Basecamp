#!/bin/bash
# Traffic light switching algorithm
GREEN='\033[32m'
AMBER='\033[33m'
RED='\033[31m'
RESET='\033[0m'
clear
while true;
do
# RED light 
for (( t=36; t > 1; t--))
do
echo -e $RED"\u2B24"
if [ $t -ge 10 ]
then
echo -e $RED$t
else
echo -e $RED" "$t
fi
echo -e $RESET"" 
sleep 1 
clear
done
echo -e $RED"\u2B24"
echo -e $AMBER"\u2B24"
echo -e $RESET""
sleep 1
clear
# Green light
for (( t=25; t > 3; t--))
do
echo -e $RESET""
if [ $t -ge 10 ]
then
echo -e $GREEN$t
else
echo -e $GREEN" "$t
fi
echo -e $GREEN"\u2B24"
sleep 1 
clear
done
# Green is blinking
for (( t=3; t > 0; t--))
do
echo -e $RESET""
echo -e $GREEN" "$t
echo -e $RESET""
sleep 0.5
clear
echo -e $RESET""
echo -e $GREEN" "$t
echo -e $GREEN"\u2B24"
sleep 0.5
clear
done
# Amber light
echo -e $RESET""
echo -e $AMBER"\u2B24"
echo -e $RESET""
sleep 3
clear
done