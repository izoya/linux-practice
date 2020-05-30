#!/bin/bash
# set -e


usage(){
  cat << EOF
The script removes empty lines from file 
and transform text to upper case.
Usage: $0 SOURCE DESTINATION
Options:
 SOURCE - specify from what file take data to transform
 DESTINATION - (optional) specify file to save result  
Examples:
  $0 --help - print this help
  $0 ~/to_transform.txt
  $0 ~/to_transform.txt ~/transformed.txt
EOF
}
transform(){
  cat $1 | \
  sed -E 'y/абвгдеёжзийклмнопрстуфхцчшщъыьэюя/АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯ/' | \
  sed -En 's/[[:blank:]]//p' | tr [[:lower:]] [[:upper:]]
}

while [ $# -gt 0 ] ; do

  if [ "$1" == "--help" ] 
  then
    usage
    exit 0
  fi

  if [ -f $1 ] ; then
    if [ $2 ] ; then
      transform $1 >> $2
      if [[ $? == 0 ]] ; then
        echo "The result was written to file $2"
      fi
    else
      transform $1
    fi
    echo $?
    break 1
  fi

  shift
done  
