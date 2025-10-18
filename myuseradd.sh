#!/bin/bash
#
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
			print_usage
			exit 1
			;;
	esac
}
parse_command_options "$@"

