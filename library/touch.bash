#!/bin/bash
source $1
state=${state:-present}
if [[ $state == "present" ]];then
   if [ ! -e $file ];then
        touch $file
        echo "${content}" > $file
	echo { \"changed\": true }
        exit 0
    else
        echo { \"changed\": true }
        exit 0
    fi
fi

if [[ $state == "absent" ]];then
   if [ ! -e $file ];then
        rm $file
        echo { \"changed\": true }
        exit 0
    else
        echo { \"changed\": true }
        exit 0
    fi
fi
