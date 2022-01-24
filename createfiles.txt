#!/bin/bash 
umask 002
workdir=$PWD
echo $0
echo $1
tempfile="/tmp/tempfile"
touch ${tempfile}
if [ $? -ne 0 ]
then
    exit 1
fi
if [ -z $1 ]
then
    find . -type f -not -type d > ${tempfile}
else
    find $1 -type f -not -type d > ${tempfile}
fi
sed -i "s@^.@${workdir}@g" ${tempfile}
mv ${tempfile} files.txt
rm -f ${tempfile}