**Shell2WebP**

Shell2WebP is a simple Bash script for converting images in the current directory to the WebP format and optionally deleting the originals. 

**Prerequisites**

Before you start, make sure `cwebp` is installed on your system. It's part of the WebP package and can be installed on Ubuntu or Debian-based systems with:

**sudo apt-get updatesudo apt-get install webp**


**Installation**

1.  Clone the repository 
    
2.  Make the script executable:**chmod +x setup.sh**

3.  Run the setup script **./setup.sh** 
    

**Global Installation**

The setup script will sort out making the script globally accessible by creating an alias webp.


1.  Rename the script to **webp**:**mv webp.sh webp**
    
2.  Move it to **/usr/local/bin**:**sudo mv webp /usr/local/bin/webp**
    

This setup allows you to run the script from any directory by typing **webp**.

**Usage**

Navigate to the directory containing the images you want to convert and type **webp** and hit enter. Confirm the conversion when prompted. The script converts all images in the current directory to WebP and deletes the originals if you confirm.

**Supported Image Formats**

*   JPEG
    
*   PNG
    
*   GIF
    

