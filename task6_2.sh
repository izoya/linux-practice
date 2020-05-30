#!/bin/bash
set -e

usage(){
  cat << EOF
The script monitors /var/log/auth.log file
and display messages of failed authorization attempts 
via ssh, terminal or gui application.
EOF
}

while [ $# -gt 0 ] ; do
  if [ "$1" == "--help" ] ; then
    usage
    exit 0
  fi
  shift
done

tail -f -n 25 /var/log/auth.log | while read LINE; do 
	if ( echo $LINE | grep failure 1> /dev/null 2>&1 ) ; then
		echo $LINE | sed -En 's/([A-Z][a-z]+ [0-9]{1,2} [0-9:]{8}).* (sshd|login|gdm).*/\1 Authorization via "\2" failed/p'
	fi
done
