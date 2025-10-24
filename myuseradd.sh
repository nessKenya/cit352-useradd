#!/bin/bash
##Author: Nelson Muchonji Bifwoli
#

function print_usage() {
	echo "Usage: myuseradd.sh -a <login> <passwd> <shell> - add a user account"
	echo "myuseradd.sh -d <login>  -remove a user account"
	echo "myuseradd.sh -h         - display this usage message"
}

function delete_user() {
	echo "delete_user"
}

function add_user() {
	echo "add_user"
}

function parse_command_options () {
	if [ $# -eq 0 ]; then
		print_usage
		exit 1
	fi

	case "$1" in
		-h)
			print_usage
			;;
		-d)
			delete_user "2"
			;;
		-a)
			add_user "$2" "$3" "$4"
			;;
		*)

			echo "ERROR : Invalid option $1"

#Author: Nelson Muchonji Bifwoli
#

#Check if running as root
if [[ $EUID -ne 0 ]];
then
echo "ERROR: This script must be run as root."
exit 1
fi

#Function to add a user
add_user() {
local username=$1
local password=$2
local shell=$3

#Check if user already exists
if id "$username" &>/dev/null; then
echo "ERROR: $username exists"
exit 1
fi

#Create user with home directory and given shell
useradd -m -s "$shell" "$username"

#Set user password
echo "$username:$password" | chpasswd

#Verify creation
if id "$username" &>/dev/null; then
echo "$username ($password) with $shell is added"
else
echo "ERROR: Failed to add $username"
fi
}

#Function to delete a user
delete_user() {
local username=$1

#Check if username is provided
if [[ -z "$username" ]]; then
echo "Usage: ./myuseradd.sh -d <username>"
exit 1
fi

#Check if user exists
if ! id "$username" &>/dev/null; then
echo "ERROR: $username does not exist"
exit 1
fi

#Delete user and their home directory
userdel -r "$username"

#Verify deletion
if ! id "$username" &>/dev/null; then
echo "$username is deleted"
else
echo "ERROR: Failed to delete $username"
fi
}

#Main script logic
case "$1" in
-a)
add_user "$2" "$3" "$4"
;;

-d)
delete_user "$2"
;;
*)

echo "Usage:"
echo " ./myuseradd.sh -a <username> <password> <shell>"
echo " ./myuseradd.sh -d <username>"
exit 1
;;
esac
