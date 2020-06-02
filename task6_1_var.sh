#!/bin/bash

usage(){
  cat << EOF
Script will capitalize characters and remove empty srtings
in the specified file

Examples:
  $0 --help - print this help
  $0 file1
EOF
}
# Нет ни одного параметра
[[ $# == 0 ]] && echo "File not specified" && usage && exit 1
# Более одного параметра
[[ $# -gt 1 ]] && echo "More than one file '$@' specified" && usage && exit 2
# Файл не существует
[[ ! -e $1 ]] && echo "File '$@' does not exist" && usage && exit 3

# Преобразование
# Замена маленьких на большие  #убрать пустые строки
sed -i 's/\(.*\)/\U\1/; /^[[:blank:]]*$/d' $1