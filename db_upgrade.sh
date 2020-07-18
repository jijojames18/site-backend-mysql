#!/bin/bash

HOST='localhost'
PORT=3306
DB='mydb'
USER='root'
PASS=""

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

if [ -z ${PASSWORD+x} ]
then
  mysql_connect="mysql $DB -u $USER -h $HOST"
else
  mysql_connect="mysql $DB -u $USER -h $HOST -p $PASSWORD"   
fi

tables_list_query="$mysql_connect -se 'SHOW TABLES'"
tables_list=$(eval $tables_list_query)

has_upgrade_table=$(echo ${tables_list[@]} | grep -o "upgrade_history" | wc -w)

if [ $has_upgrade_table == 1 ]
then
  echo "An existing DB is present"
else
  echo "Recreating DB from start"
  for folder in `ls sql`; do
    for file in `ls sql/$folder`; do
      file_path="sql/$folder/$file"
      echo "***$file_path***"
      exec_query="$mysql_connect < $file_path"
      $(eval $exec_query)
    done
  done
fi

