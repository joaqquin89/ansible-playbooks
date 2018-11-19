#!/bin/bash
source $1
fdisk -l |grep /dev/ |grep -v mapper |grep -v Linux |awk -F":" '{ print $1}'|sort -n > /tmp/disks.out
HOST=`hostname -s | awk '{print tolower($0)}'`
disks=`cat /tmp/disks.out|wc -l`
if [ ${disks} == "1" ]
    then
        printf "############### WARNING ######################################\n">  /tmp/${HOST}_users_info.dat
        printf "#Solo existe ${disks} NO es posible realizar configuraciones #\n">> /tmp/${HOST}_users_info.dat
        printf "#de estructura de Filesystem y Usuarios                      #\n">> /tmp/${HOST}_users_info.dat
        printf "#Favor revisar datos de Aprovisionamiento                    #\n">> /tmp/${HOST}_users_info.dat
        printf "############### WARNING ######################################\n">> /tmp/${HOST}_users_info.dat
        echo { \"failed\": true , "msg": "one disk is not include in the standart"}
        exit 0
fi
if [ ${disks} == "2" ]
    then
        TIPO="APP"
        if [ "$TIPO" == "${profile}" ];then
            echo { \"changed\": true }
            exit 0
        else
            echo { \"failed\": true , "msg": "Profile type ${profile} not APP"}
            exit 0
        fi
fi
if [ ${disks} -gt 2 ]
    then
        TIPO="BD"
        if [ "$TIPO" == "${profile}" ];then
            echo { \"changed\": true }
            exit 0
        else
            echo { \"failed\": true , "msg": "Profile type ${profile} not BD"}
            exit 0
        fi
    fi
fi
