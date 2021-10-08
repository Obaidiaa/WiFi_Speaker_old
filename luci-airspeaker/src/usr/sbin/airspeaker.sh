#!/bin/sh


devicename=$(uci get shairport-sync.shairport_sync.name)


$(uci set wireless.@wifi-iface[0].ssid=${devicename}_AirSpeaker)
$(uci set system.@system[0].hostname=${devicename}_AirSpeaker)
$(uci commit)

$(/etc/init.d/shairport-sync enable)
$(/etc/init.d/shairport-sync restart)

echo $devicename
