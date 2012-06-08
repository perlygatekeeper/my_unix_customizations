#!/bin/bash
#
# 2009/04/30 - SAF: Set permissions on directories & files of group managed websites

# Set permissions on directories, supports directory names with spaces
echo -e "\n\nFixing directory permissions..."
find . -type d | while read DIRECTORY
do
   chmod 775 "$DIRECTORY"
done

# Set permissions on files, supports file names with spaces
echo -e "Fixing file permissions...\n\n"
find . -type f | while read FILE
do
   chmod 664 "$FILE"
done
