**Shell2WebP**

Shell2WebP is a simple Bash script for automating the conversion of images in the current directory to the WebP format and optionally deleting the originals. It's ideal for web developers and photographers looking to optimise their image sizes for improved loading times on websites.

**Prerequisites**

Before using this script, ensure **cwebp** is installed on your system. It's part of the WebP package and can be installed on Ubuntu or Debian-based systems with:

**sudo apt-get updatesudo apt-get install webp**

For other operating systems, please refer to the WebP documentation for installation instructions.

**Installation**

1.  Clone the repository or download the **webp.sh** script to your local machine.
    
2.  Make the script executable:**chmod +x webp.sh**
    

**Global Installation**

For convenience, you can make the script globally accessible:

1.  Rename the script to **webp**:**mv webp.sh webp**
    
2.  Move it to **/usr/local/bin**:**sudo mv webp /usr/local/bin/webp**
    

This setup allows you to run the script from any directory by typing **webp**.

**Usage**

Navigate to the directory containing the images you want to convert and type **webp**. Confirm the conversion when prompted. The script converts all images in the current directory to WebP and deletes the originals if you confirm.

**Supported Image Formats**

*   JPEG
    
*   PNG
    
*   GIF
    

**Customization**

The script uses a default quality setting of 80 for conversion. You can adjust this by modifying the **\-q** parameter in the script.

**Contributing**

Contributions are welcome. Feel free to fork the repository, make changes, and submit pull requests. Open an issue for any bugs or improvement suggestions.

**License**

Shell2WebP is released under the MIT License. See the LICENSE file for more details.