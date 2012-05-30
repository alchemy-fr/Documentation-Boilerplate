#!/bin/bash

DEST=$1
FORCE=0
UPDATE=0
ERROR=""

function printHelp() {
	echo "usage: generator.sh DEST [-f|--force] [-u|--update]"
	echo ""
	echo "positional arguments:"
	echo "  DEST           destination (absolute path)"
	echo ""
	echo "optional arguments:"
	echo "  -h, --help     show this help message and exit"
	echo "  -f, --force    force the execution of the script"
	echo "  -u, --update   update the doc"

}

function testIfDestinationIsEmpty() {
	if [ -e $DEST ]
	then
		if [ "$(ls -A "$DEST")" ]
		then
			echo "1"
		else
			echo "0"
		fi
	else
		mkdir $DEST
		echo "0"
	fi
}

for argument in $*
do
	case $argument in
		$DEST)
			;;
		"-u"|"--update")
			UPDATE=1
			;;
		"-f"|"--force")
			FORCE=1
			;;
		"-h"|"--help")
			printHelp
			exit 0
			;;
		*)
			ERRORS=$ERRORS" "$argument
	esac
done

DEST=$DEST/docs

if [ -n "$ERRORS" ]
then
	echo ""
	for error in $ERRORS
	do
		echo "/!\\ UNKNOWN ARGUMENT : $error. /!\\"
	done
	echo ""
	echo ""
	printHelp
	exit 1
fi

if [ $FORCE -eq 0 ] && [ $UPDATE -eq 0 ]
then
	if [ $(testIfDestinationIsEmpty) -eq 0 ]
	then
		cp -rf boilerplate/* $DEST
	else
		echo "$DEST is not empty"
		echo "Use --force to override data or --update to update files"
		exit 1
	fi
elif [ $FORCE -eq 0 ] && [ $UPDATE -eq 1 ]
then
        rsync -vrq \
            --exclude='source/local_conf.py' \
            --exclude='source/_themes/Alchemy/ribbon.html' \
            --exclude='source/_themes/Alchemy/searchbox.html' \
            --exclude='source/_themes/Alchemy/static/main.css' \
            --exclude='source/index.rst' \
            boilerplate/* $DEST

elif [ $FORCE -eq 1 ]
then
	cp -rf boilerplate/* $DEST
fi

if [ $? -gt 0 ]; then
    echo "Error while executing command !"
else
    echo "Success !"
fi
