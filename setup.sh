#!/bin/bash

# Function to check if a directory is in PATH
is_in_path() {
    echo "$PATH" | tr ':' '\n' | grep -q -E "^$1$"
}

# Directory to store the script
TARGET_DIR="$HOME/.local/bin"

# Create the directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Copy the Shell2Webp.sh script to the TARGET_DIR
SCRIPT_NAME="Shell2Webp.sh"
cp "$SCRIPT_NAME" "$TARGET_DIR/$SCRIPT_NAME"
chmod +x "$TARGET_DIR/$SCRIPT_NAME"

# Add TARGET_DIR to PATH if it's not already there
if ! is_in_path "$TARGET_DIR"; then
    echo "export PATH=\$PATH:$TARGET_DIR" >> "$HOME/.bashrc"
    export PATH=$PATH:$TARGET_DIR
    echo "Added $TARGET_DIR to PATH. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
else
    echo "$TARGET_DIR is already in PATH."
fi

# Create an alias for the script
ALIAS_NAME="webp"
if ! grep -q "alias $ALIAS_NAME=" "$HOME/.bashrc"; then
    echo "alias $ALIAS_NAME='$TARGET_DIR/$SCRIPT_NAME'" >> "$HOME/.bashrc"
    echo "Alias $ALIAS_NAME created. Please restart your terminal or run 'source ~/.bashrc' to apply changes."
else
    echo "Alias $ALIAS_NAME already exists in .bashrc."
fi

# Check for cwebp installation
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

# Install cwebp if not present
check_cwebp

# Install rsvg-convert or ImageMagick if not present
check_svg_converter

# Inform the user
echo "Setup complete. You can now use the webp command to convert images (JPG, JPEG, PNG, GIF, and SVG) to WebP."
echo "To convert images to WebP, run: webp"
