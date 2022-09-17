#!/bin/bash
COMMAND=finder
function errorExit() 
{
    echo
    echo "<$COMMAND: ERROR> $1"
    echo
    echo "usage: $COMMAND <min_size> <max_size> <directory>"
    echo
    exit 1
}
function isNumber() 
{
    echo $1 | grep "^[0-9]*$" > /dev/null
    return $?
}
if [ $# -lt 3 ]; then
    errorExit "Too few arguments: $#"
elif [ ! -d $3 ]; then
    errorExit "$3 id not directory"
fi
isNumber $1
if [ ! $? == 0 ]; then
    errorExit "First argument is not a number."
fi
isNumber $2
if [ ! $? == 0 ]; then
    errorExit "Second argument is not a number."
fi
find $3 -size +$1c -size -$2c -printf "<$COMMAND: %s>\t%p\n"
