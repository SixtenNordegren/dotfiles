#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <password> <encryptedfile> <outputfile>"
    exit 1
fi

PASSWORD=$1
ENCRYPTED_FILE=$2
OUTPUT_FILE=$3

# Decrypt the file using openssl
openssl enc -d -aes-256-cbc -in "$ENCRYPTED_FILE" -out "$OUTPUT_FILE" -pass pass:"$PASSWORD"

# Check if decryption was successful
if [ $? -eq 0 ]; then
    echo "Decryption successful. Output saved to $OUTPUT_FILE."
else
    echo "Decryption failed."
fi
