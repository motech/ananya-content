#!/bin/bash
# This script trims first and last n seconds of a wav file and appends then to create a shorter 2n length wav file.
# It converts all the .wav files(except for one with "prompt" in their name) in the "audio" folder

audioDir=`pwd`"/audio"
audioTestDir=$audioDir"Test"
soxDir="tools/sox-14-3-2"

IFS=$'\n'
rm -rf "$audioTestDir"
cp -r "$audioDir" "$audioTestDir"
cd "$soxDir"

for f in `find "$audioTestDir" -type f |grep .*.wav | grep -v .*prompt.*.wav`; do
  LEN=`sox "$f" -n stat 2>&1 | sed -n 's#^Length (seconds):[^0-9]*\([0-9.]*\)$#\1#p'`
  LEN=${LEN/.*}
  if [ ! -z $LEN ] && [ $LEN -gt 20 ]; then
	LAST=$(($LEN - 10))
	sox.exe "$f" first.wav trim 0 0:10
    sox.exe "$f" last.wav trim $LAST $LEN
	sox.exe first.wav last.wav "$f"
  fi
done
rm -f first.wav
rm -f last.wav