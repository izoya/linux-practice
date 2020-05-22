#!/bin/bash

group1=web
group2=geekbrains
user=rockstar
uid=143


function createGroup {
	sudo groupadd $1 1> /dev/null 2>&1
	if [[ $? == 0 ]]
	then
		echo "\"$1\" group was successfully created."
	else
		echo "\"$1\" group already exists."
	fi

	echo "GID: " $(cat /etc/group | grep $1: | cut -d ':' -f3)
	groupUsers=$(cat /etc/group | grep $1: | cut -d ':' -f4)

	if [ "$groupUsers" = "" ] #if [ $groupUsers ]
	then
		echo "There are no users in the group"
	else
		echo "Users in the group: " $groupUsers
	fi
	echo 
}

createGroup $group1
createGroup $group2

sudo useradd $user -u $uid -g $group1 -G $group2 1> /dev/null 2>&1


if [[ $? == 0 ]]
then
	echo "User $user was added successfully."
else 
	# Если пользователь уже существует, необходимо удостовериться, 
	# что настройки выше указаны верно. 
	echo "User $user already exists"

	# checking uid
	currentUid=$(cat /etc/passwd | grep $user: | cut -d ':' -f3)
	if [[ $currentUid == $uid ]]
	then
		echo "User id is correct: $currentUid."
	else 
		sudo usermod -u $uid $user
		if [[ $? == 0 ]]
			then echo "User's id was changed to $uid."
		fi
	fi 

	# checking groups
	groups=$(id $user | cut -d ' ' -f3)
	if [[ $groups == *$group1* && $groups == *$group2* ]] 
		then echo "User's groups are correct: $group1, $group2."
	else
		sudo usermod -g $group1 -aG $group2 $user
		if [[ $? == 0 ]]
			then echo "User's groups was changed to $group1, $group2."
		fi
	fi
fi