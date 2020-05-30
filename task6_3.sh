#!/bin/bash
# set -e

# Скрипт должен выводить информацию о том, как его использовать

usage(){
  cat << EOF
The script creates a directory and files in it.

Usage: $0 [FILE(S)] -d DIRECTORY

Options:
 --help - print this help
 -d - specify the next parameter as a directory name
 [FILE(S)] - specify one or more files to create in the directory

Examples:
  $0 -d /tmp/task_3
  $0 file1 file2 -d dire file3
  $0 -d file1 file2 file3
	$0 -d /tmp/task_3 file1 file2.sh file3
	$0 -d /tmp/task_3 -d /tmp/task_3_2 file1 file2.sh file3 - error, only one -d parameter accept

EOF
}
if [[ $# == 0 ]] ; then
	echo -e "No script params specified" 
	exit 1
fi

while [ $# -gt 0 ] ; do
  if [ "$1" == "--help" ] ; then
    usage
    exit 0
  fi
  if [ "$1" == "-d" ] ; then
  	# Если указано несколько директорий, то выводить ошибку с соответствующей информацией. 
  	if [[ -n $DIR ]] ; then
  		echo "Attempt to specify more than one directory"
  		exit 2
  	fi
  	DIR="$2"
  	shift 2
  	continue
  fi
  FILES+=("$1")
  shift
done

# Скрипт должен выводить понятные сообщения об ошибках
(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 3
if [[ -z $DIR ]] ; then
	echo "Directory not specified"
	exit 4
fi


# в указанной с помощью параметра -d директории создает указанные файлы. 
if [[ -d $DIR ]] ; then
	echo "Directory \"$DIR\" already exists"
else
	if mkdir $DIR ; then
		echo -e "Directory \"$DIR\" created"
	fi
fi
echo

for file in ${FILES[@]} ; do
	# Если какой-либо из указанных файлов уже существует, то выводить предупреждение на экран.
	if [[ -f $DIR/$file ]] ; then
		echo "File \"$file\" already exists"
	else
		if touch $DIR/$file ; then
			echo "File \"$file\" created"
		fi
	fi
	# Созданным файлам, которые имеют расширение .sh нужно дать права на выполнение. 
	if echo $file | grep -Eq '\.sh$' ; then
		chmod +x $DIR/$file
	fi
done
echo
ls -la $DIR | tail -n +4
