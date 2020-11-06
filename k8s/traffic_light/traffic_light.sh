#!/bin/bash
# Traffic light switching algorithm
GREEN='\033[32m'
AMBER='\033[33m'
RED='\033[31m'
RESET='\033[0m'
while true;
do
# RED light 
echo -e $RED"/REDON"
for (( t=36; t > 1; t--))
do
echo -e $RED$t
sleep 1 
done
echo -e $AMBER"/AMBERON"
sleep 1
echo -e $RESET"/REDOFF"
echo -e $RESET"/AMBEROFF"
# Green light
echo -e $GREEN"/GREENON"
for (( t=25; t > 3; t--))
do
echo -e $GREEN$t
sleep 1 
done
# Green is blinking
echo -e $RESET"/GREENOFF"
for (( t=3; t > 0; t--))
do
sleep 0.5
echo -e $GREEN$t
echo -e $GREEN"/GREENON"
sleep 0.5
echo -e $RESET"/GREENOFF"
done
# Amber light
echo -e $AMBER"/AMBERON"
sleep 3
echo -e $RESET"/AMBEROFF"
done