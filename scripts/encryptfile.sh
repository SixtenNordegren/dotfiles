#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <password> <inputfile> <outputfile>"
    exit 1
fi

PASSWORD=$1
INPUT_FILE=$2
OUTPUT_FILE=$3

# Encrypt the file using openssl
openssl enc -aes-256-cbc -salt -in "$INPUT_FILE" -out "$OUTPUT_FILE" -pass pass:"$PASSWORD"

# Check if encryption was successful
if [ $? -eq 0 ]; then
    echo "Encryption successful. Output saved to $OUTPUT_FILE."
else
    echo "Encryption failed."
fi
