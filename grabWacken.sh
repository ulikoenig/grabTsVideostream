#!/bin/bash
STARTURL="https://streaming-magenta-music-360.akamaized.net/hls/live/573870/magentamusik1/magentamusik1_1/magentamusik1.m3u8"
RELURL="https://streaming-magenta-music-360.akamaized.net/hls/live/573870/magentamusik1/magentamusik1_1/"

while [ 1 ]
do
        WAIT=0
        curl -s $STARTURL | tr -d '\r'  | sed '/^#/ d' |
        while read -r line
        do
                RESULT=$(wget  -N  "$RELURL$line"  2>&1 | grep 304)
                if [ -n "$RESULT" ]; then
                        #echo "slower"
                        WAIT=$((WAIT+1))
                        let WAIT++;
                        #echo "WAIT = $WAIT"
                fi
                echo $WAIT > /tmp/leechwait
        done

        WAIT=$(cat  /tmp/leechwait)
        WAIT=$((WAIT * 3))
        echo -n "."
        sleep $WAIT

done
