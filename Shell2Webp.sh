#!/bin/bash

# Function to check if cwebp is installed
check_cwebp() {
    if ! command -v cwebp &> /dev/null
    then
        echo "cwebp could not be found. Attempting to install..."
        sudo apt-get update
        sudo apt-get install -y webp

        # Verify the installation
        if ! command -v cwebp &> /dev/null
        then
            echo "Installation of cwebp failed. Exiting."
            exit 1
        fi
    fi
}

# Check for cwebp
check_cwebp

# Ask for confirmation
read -p "Convert all images in the current directory to WebP and delete the originals? (y/n) " -n 1 -r
echo    # Move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Initialise a counter for processed files
    count=0

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
                echo "Converted and deleted: $file"
                count=$((count + 1))
            else
                echo "Failed to convert $file"
            fi
        fi
    done

    # Provide feedback on the number of files processed
    if [ $count -gt 0 ]; then
        echo "$count files were successfully converted and deleted."
    else
        echo "No files were converted."
    fi
else
    echo "Conversion cancelled."
fi
