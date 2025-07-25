#!/bin/bash
# Set up properly with t -d to specify config file
TODO_FILE="~/.todo/todo.txt"

i3status | while :
do
POMODORO_STATUS=$(pomodoro -g)
TASKS=$(grep -c -v '^x ' "$TODO_FILE")
if [ "$POMODORO_STATUS" = "" ]; then
    read line
    echo "Tasks: $TASKS | $line" || exit 1
else
    read line
	 echo "Pomodoro: $POMODORO_STATUS | Tasks: $TASKS | $line" || exit 1
fi
done

