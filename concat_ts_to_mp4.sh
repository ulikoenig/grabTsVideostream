#!/bin/bash
echo -n "" > filelist.txt
ls -1 *.ts |
        while read -r line
        do
                echo "file '$line'" >> filelist.txt
        done
ffmpeg -f concat -i filelist.txt -c copy all.ts && ffmpeg -i all.ts -acodec copy -vcodec copy -movflags +faststart all.mp4 && rm all.ts filelist.txt
