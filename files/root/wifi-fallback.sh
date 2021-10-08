#!/bin/sh

source /lib/functions/network.sh
network_find_wan NET_IF
network_get_ipaddr NET_ADDR "${NET_IF}"
echo "${NET_ADDR}"

ISCONNECTED="`ifstatus wwan | grep -e '"up":'`"
echo $ISCONNECTED



case "$ISCONNECTED" in
    *"true"*)

    disabled=`uci get wireless.@wifi-iface[0].disabled`
    if [ $disabled == "1" ]; then
        echo "disabled no need furter action"
        else
        echo "enabled need to be disabled"
        echo `uci set wireless.@wifi-iface[0].disabled=1`
        echo `uci commit`
        echo `wifi`
    fi
    
    ;;
    
    *) 

    disabled=`uci get wireless.@wifi-iface[0].disabled`
    if [ $disabled == "0" ]; then
        echo "enabled no need furter action"
        else
        echo "disabled need to be enabled"
        echo `uci set wireless.@wifi-iface[0].disabled=0`
        echo `uci commit`
        echo `wifi`
    fi
    ;;
esac

