#!/bin/bash

HOST='localhost'
PORT=3306
DB='mydb'
USER='root'
PASS=''

while [ "$1" ];
do
  arg=$1
  shift
  value=
  case $arg in 
    "-h")
      HOST=$1
      ;;
    "-p")
      PORT=$1
      ;;
    "-a")
      PASSWORD=$1
      ;;
    "-d")
      DB=$1
      ;;
    "-u")
      USER=$1
      ;;  
  esac
done

echo -e "\n"
echo "Connecting to DB $DB at $HOST:$PORT as $USER"




