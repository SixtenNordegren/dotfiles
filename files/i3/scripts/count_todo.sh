#!/bin/bash

# Path to your todo.txt file
TODO_FILE="/home/sixten/.todo-txt/todo.txt"

# This script prepends i3status output with the count of unfinished tasks
i3status | while :
do
    read line
    unfinished_tasks=$(grep -c -v '^x ' "$TODO_FILE")
    echo "Tasks: $unfinished_tasks | $line" || exit 1
done

