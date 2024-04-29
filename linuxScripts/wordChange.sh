#! /usr/bin/bash

# MCX- Simple Shell script to replace some words

echo "Starting the Script 1 - Replace words in a file"

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file> <pattern_to_replace> <replacement_pattern>"
    exit 1
fi

# Assign arguments to variables
file="$1"
pattern_to_replace="$2"
replacement_pattern="$3"


# sed to replace the pattern in the file
sed -i "s/$pattern_to_replace/$replacement_pattern/g" "$file"

echo "Done."