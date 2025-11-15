#!/bin/bash

# Load reusable display function
source messages.sh

file_name="$1"

# Validate argument
if [ -z "$file_name" ]; then
    echo "Error: No file specified."
    exit 1
fi

# Check file existence
if [ ! -f "$file_name" ]; then
    echo "Error: File '$file_name' does not exist."
    exit 1
fi

# Verify ELF file type
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: '$file_name' is not an ELF file."
    exit 1
fi

###############################################
# Extract ELF Header Information
###############################################

# Magic Number (cut bytes 1–4)
magic_number=$(readelf -h "$file_name" | grep "Magic:" | sed 's/.*Magic://;s/ //')

# Class (ELF32 / ELF64)
class=$(readelf -h "$file_name" | grep "Class:" | awk -F: '{print $2}' | xargs)

# Byte Order (LSB/MSB)
byte_order=$(readelf -h "$file_name" | grep "Data:" | awk -F: '{print $2}' | xargs)

# Entry point address
entry_point_address=$(readelf -h "$file_name" | grep "Entry point address:" | awk -F: '{print $2}' | xargs)


###############################################
# Display Using messages.sh Function
###############################################

display_elf_header_info
