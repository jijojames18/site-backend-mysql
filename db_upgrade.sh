#!/bin/bash

HOST="localhost"
PORT=3306
DB="mydb"
USER="root"
PASS=""

while [ "$1" ];
do
  arg=$1
  shift
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
  mysql_check_db="mysql -u $USER -h $HOST"
else
  mysql_connect="mysql $DB -u $USER -h $HOST -p $PASSWORD"
  mysql_check_db="mysql -u $USER -h $HOST -p $PASSWORD"
fi

db_list=$($mysql_check_db -se 'SHOW DATABASES')
if [ $? != 0 ]
then
  exit 1
fi
has_required_db=$(echo ${db_list[@]} | grep -o "$DB" | wc -w)
if [ $has_required_db == 0 ]
then
  echo "Creating database $DB"
  $($mysql_check_db -se 'CREATE DATABASE $DB')
  if [ $? != 0 ]
  then
    exit 1
  fi
fi

tables_list=$($mysql_connect -se 'SHOW TABLES')
if [ $? != 0 ]
then
  exit 1
fi
has_upgrade_table=$(echo ${tables_list[@]} | grep -o "upgrade_history" | wc -w)
final_version="v1"
if [ $has_upgrade_table == 1 ]
then
  echo "An existing DB is present"
  last_executed_file=$($mysql_connect -se 'SELECT * FROM upgrade_history')
  last_folder=$(echo "$last_executed_file" | cut -d "/" -f 2)
  last_file=$(echo "$last_executed_file" | cut -d "/" -f 3)
  last_version="${last_folder:1}"
  last_file_version=$(echo "$last_file" | cut -d "-" -f 1)
  for current_folder in `ls sql`; do
    current_version="${current_folder:1}"
    if [ $current_version -ge $last_version ]
    then
      final_version=$current_folder
      for current_file in `ls sql/$current_folder`; do
        current_file_version=$(echo "$current_file" | cut -d "-" -f 1)
        if [ $current_file_version -gt $last_file_version ]
        then
          file_path="sql/$current_folder/$current_file"
          echo "***$file_path***"
          $($mysql_connect < $file_path)
          if [ $? != 0 ]
          then
            exit 1
          fi
          if [ $file_path != "sql/v1/001-initial.sql" ]
          then
            $($mysql_connect -se 'TRUNCATE upgrade_history; INSERT INTO upgrade_history VALUES(\"$file_path\")')
            if [ $? != 0 ]
            then
              exit 1
            fi
          fi
        fi
      done
    fi
  done
else
  echo "Recreating DB from start"
  for folder in `ls sql`; do
    for file in `ls sql/$folder`; do
      final_version=$folder
      file_path="sql/$folder/$file"
      echo "***$file_path***"
      $($mysql_connect < $file_path)
      if [ $? != 0 ]
      then
        exit 1
      fi
      if [ $file_path != "sql/v1/001-initial.sql" ]
      then
        $($mysql_connect -se 'TRUNCATE upgrade_history; INSERT INTO upgrade_history VALUES(\"$file_path\")')
        if [ $? != 0 ]
        then
          exit 1
        fi
      fi
    done
  done
fi

echo "Database upgraded to version $final_version"
