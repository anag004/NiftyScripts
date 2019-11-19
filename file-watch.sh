#!/bin/zsh

# Script to automatically make all .cpp files in a specified directory

# TODO: Give the ability to be able to specify list of files OR specify a command that lists all files
# TODO: Give the ability to specify the command to be run on the filename

declare -A modTimes

spin='-\|/'
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

i=0
while true
do
    i=$(( (i+1) %4 ))
    printf "\r$GREEN Waiting for file changes ${spin:$i:1} $NOCOLOR"
    sleep 0.1

    for file in $( find $1 -name "*.cpp" ) 
    do
        newTime=$( stat -f %a $file )
        if [[ ${modTimes[$file]} == $newTime ]] 
        then
            :
        else 
            make ${file%????}
            modTimes[$file]=$newTime
        fi 
    done
done

echo ${modTimes[foo]}

