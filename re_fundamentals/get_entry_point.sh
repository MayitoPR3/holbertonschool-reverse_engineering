#!/bin/bash

source messages.sh

file_name="$1"

# Check for file
if [ -z "$file_name" ]; then
    echo "Error: No file specified."
    exit 1
fi

if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Verify ELF
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

###############################################
# Extract ELF Header Info
###############################################

# Remove leading spaces and trailing spaces
magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/.*Magic://;s/^ *//;s/ *$//')

class=$(readelf -h "$file_name" | grep "Class:" | sed 's/.*Class://;s/^ *//')

byte_order=$(readelf -h "$file_name" | grep "Data:" | sed 's/.*Data:.*,//;s/^ *//')

entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | sed 's/.*://;s/^ *//')

###############################################
display_elf_header_info
