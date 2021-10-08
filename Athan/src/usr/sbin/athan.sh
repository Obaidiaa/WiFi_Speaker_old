#!/bin/sh

# filename=$(uci get athan.@Athan[0].athanfile)

# mv $filename /usr/sbin/athan/sound/athan.mp3

# $(uci set athan.@Athan[0].athanfile=/usr/sbin/athan/sound/Athan.mp3)
# $(uci commit)

python3 /usr/sbin/athan/athan.py


# test=$(uci get athan.@Athan[0])
# echo $test

