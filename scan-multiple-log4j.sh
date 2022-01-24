#!/bin/bash

CONNECT=$1
CONNECT_ARRAY=($(echo ${CONNECT} | tr "@" "\n"))
IP_HOST="${CONNECT_ARRAY[1]}"
HOST="${CONNECT}"

PASSWORD=$2
REVERSE_HOST=$3
REVERSE_PORT=$4

session_name=log4j-scanning

directory=$(pwd)
cd ${directory} && tmux new-session -s ${session_name} -d

FILENAME=hosts

LINES=$(cat $FILENAME)
COUNTER=1

for LINE in $LINES
do
	echo "$LINE"
	short="$(echo $LINE | tr -d '.')"
	window=${session_name}:${COUNTER}
	pane=${window1}.1

	tmux select-window -t "${window}"
	tmux send-keys -t "${pane}" "echo ${short}" ENTER
	tmux send-keys -t "${pane}" "./log4jscanner.sh $LINE" ENTER

	tmux new-window
	COUNTER=$((COUNTER+1))
done
