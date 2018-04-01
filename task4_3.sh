#!/bin/bash
#own justocer
mkdir /tmp/backups  2>/dev/null
#solve for space
# 1_IFS=$IFS
# IFS=$'\n'
#check number or not
if [[ ${!#} != [0-9]* ]]; then
exec >&2
echo "Error: you need enter number of backups"
exit 1
 else
number=$#
1_IFS=$IFS
IFS=$'\n'
SRCDIR="${@:1:$(($#-1))}"
fi
#exist of directory
if [ -d $SRCDIR ]; then
:
 else
exec >&2
echo "Error: dir doesn\'t exist"
exit 1
fi 

#SRCDIR=$1
#delete first and last / and change on -
 SRCDIRC=${SRCDIR#"/"}
 SRCDIRCHANGE=$(echo $SRCDIRC | tr '/' '-')
 DESTDIR="/tmp/backups"
 FILENAME=$SRCDIRCHANGE-$(date +%-Y%-m%-d)-$(date +%-T)
#check, count and del many backups
ololo=`find /tmp/backups/ -name $SRCDIRCHANGE* | wc -l` || 0
rock=0
if [ "$ololo" = "$rock" ]; then
:
else
$(cd /tmp/backups/ && \ls -t $SRCDIRCHANGE* | xargs -I {} rm -r -- {})
fi
#function is how many backups
# number=$2
#copy dir
 for bk in `seq $((${!#}))`; do
 cp -R $SRCDIR /tmp/backups/$FILENAME-$(date +%s%N | cut -b12-13)
 done
#rotate dir
 find /tmp/backups -type d -maxdepth 1 -mindepth 1 -exec tar zcvf {}.tar.gz {} \; &>/dev/null
#delete dir
 find /tmp/backups -type d -maxdepth 1 -mindepth 1 -exec  rm -rf {} \; 2>/dev/null
 

