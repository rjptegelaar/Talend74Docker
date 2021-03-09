#!/bin/bash                                                                                                                                   echo "Parsing file $1"

if [ $# -eq 0 ]
  then
    echo "No config file supplied"
    exit 1
fi

if [ -f "$1" ]
	then
    	echo "File $1 exists, start processing."
    else
    	echo "File $1 doesn't exist, skip processing."
    	exit 0
fi

rm -rf "$1.context"
rm -rf "$1.cron"
rm -rf "$1.params"

dos2unix $1

while IFS='=' read -r propkey propvalue || [ -n "$propkey" ]
do
 	case $propkey in
   		context) 
   			echo "--context=$propvalue" > "$1.context"
   		;;
   		cron) 
   			echo "$propvalue" > "$1.periodic" 
   		;;
   		*)   		
   			echo -n " --context_param $propkey=$propvalue" >> "$1.params"
   		;;
	esac
  	
done < "$1"

echo "Done parsing $1"