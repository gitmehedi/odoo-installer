#!/bin/bash
FILE=$1
VERSION=$2

if [ $2 ]
then
  VERSION=$2
else
  VERSION=10.0
fi

while read line
do
    git clone -b $VERSION --single-branch $line
    echo -e "Repository $element cloned successfully"
done < $FILE

echo -e "========== All Repository Cloned =========="
