#!/bin/bash
FIRST=`pwd`
BLOB="false"


while [ "$BLOB" = "false" ]; do
  BLOB="false"
  if [ -e script ]; then
    BLOB="true"
    LAST=`pwd`

  fi
  cd ..
done
cd $LAST
konsole -workdir `pwd` -e tail -n 100 -f log/development.log
cd $FIRST
