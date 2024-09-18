#!/bin/bash

# Function to check if cwebp is installed
check_cwebp() {
    if ! command -v cwebp &> /dev/null; then
        echo "cwebp could not be found. Attempting to install..."
        sudo apt-get update
        sudo apt-get install -y webp

        # Verify the installation
        if ! command -v cwebp &> /dev/null; then
            echo "Installation of cwebp failed. Exiting."
            exit 1
        fi
    fi
}

# Function to check if rsvg-convert or ImageMagick (convert) is installed for SVG processing
check_svg_converter() {
    if ! command -v rsvg-convert &> /dev/null && ! command -v convert &> /dev/null; then
        echo "Neither rsvg-convert nor ImageMagick (convert) could be found. Attempting to install librsvg2-bin or imagemagick..."
        sudo apt-get update
        sudo apt-get install -y librsvg2-bin imagemagick

        # Verify the installation
        if ! command -v rsvg-convert &> /dev/null && ! command -v convert &> /dev/null; then
            echo "Installation of a suitable SVG converter failed. Exiting."
            exit 1
        fi
    fi
}

# Check for required tools
check_cwebp
check_svg_converter

# Ask for confirmation
read -p "Convert all images (JPG, JPEG, PNG, GIF, and SVG) in the current directory to WebP and delete the originals? (y/n) " -n 1 -r
echo    # Move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Initialise a counter for processed files
    count=0

    # Loop through all image files in the current directory
    for file in *.{jpg,jpeg,png,gif,svg}; do
        # Check if the file exists to avoid errors with no matching files
        if [ -f "$file" ]; then
            # Handle SVG files separately
            if [[ "$file" == *.svg ]]; then
                # Convert SVG to PNG (using rsvg-convert or ImageMagick's convert)
                if command -v rsvg-convert &> /dev/null; then
                    rsvg-convert "$file" -o "${file%.*}.png"
                elif command -v convert &> /dev/null; then
                    convert "$file" "${file%.*}.png"
                fi
                # Convert the resulting PNG to WebP
                cwebp -q 80 "${file%.*}.png" -o "${file%.*}.webp"
                # Check if WebP conversion succeeded
                if [ $? -eq 0 ]; then
                    # Delete both original SVG and intermediate PNG file
                    rm "$file" "${file%.*}.png"
                    echo "Converted and deleted: $file"
                    count=$((count + 1))
                else
                    echo "Failed to convert $file"
                fi
            else
                # For JPG, JPEG, PNG, and GIF, directly convert to WebP
                cwebp -q 80 "$file" -o "${file%.*}.webp"
                # Check if WebP file was created successfully
                if [ $? -eq 0 ]; then
                    # Delete the original file
                    rm "$file"
                    echo "Converted and deleted: $file"
                    count=$((count + 1))
                else
                    echo "Failed to convert $file"
                fi
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
