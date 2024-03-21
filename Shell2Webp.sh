#!/bin/bash

# Ask for confirmation
read -p "Convert all images in the current directory to WebP and delete the originals? (y/n) " -n 1 -r
echo    # Move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Loop through all image files in the current directory
    for file in *.{jpg,jpeg,png,gif}; do
        # Check if the file exists to avoid errors with no matching files
        if [ -f "$file" ]; then
            # Convert the file to WebP
            cwebp -q 80 "$file" -o "${file%.*}.webp"
            # Check if the WebP file was created successfully
            if [ $? -eq 0 ]; then
                # Delete the original file
                rm "$file"
            fi
        fi
    done
else
    echo "Conversion cancelled."
fi
