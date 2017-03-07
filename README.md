# PenDrive
One-Click Command-Line Utility for file-sharing just for Developers!

<br>

<h2> Man Page like Description </h2>

# Name
pendrive - A Command-Line Utility to upload/download files like PenDrive on Cloud

# Synopsis
	pendrive [OPTION]... [FILE]... [SERVER]...

# Description
A Simple Command-Line Utility for file sharing without the hassle of finding a pendrive nearby.
	You can transfer files with your Developer Friends with just ONE LINE !!!
	Upload / Download Files at your leisure with PenDrive Cloud. Share all kinds of files, be it programs, text files, images & videos.
	Just need an Internet Connection and you're Good to Go!
	Days of carying flashdrives are gone!
	Happy File Sharing!

# Options
Describes all Options of PenDrive on Cloud

		-l		Option for Listing available files on PenDrive Cloud

		-u		Upload a File to PenDrive Cloud by providing a filename after -u option

		-d		Download a File from PenDrive Cloud by providing a filename after -d option

		-h		Provides help on how to use the pendrive command-line utility

		--server	User can provide servername explicitly as --server=["example.server-address.com"]		

# Usage
```shell
	pendrive                				# Displays Man Page of pendrive
	pendrive   -l           				# Lists all files on PenDrive Cloud
	pendrive   -u   file.ext				# Upload a file to PenDrive Cloud
	pendrive   -d   file.ext				# Download a file from PenDrive Cloud
	pendrive   -h           				# Provides Help for using PenDrive Cloud
```
alternatively,
```shell
	pendrive   -l              --server="server.io"		# Lists all files on user-specified PenDrive Cloud Server
	pendrive   -u   file.ext   --server="server.io"		# Upload a file to user-specified PenDrive Cloud Server
	pendrive   -d   file.ext   --server="server.io"		# Download a file from user-specified PenDrive Cloud Server
```
# Examples
``` shell
	pendrive
	pendrive -h
	pendrive -l or pendrive -l --server="server.io"
	pendrive -u file.ext or pendrive -u file.ext --server="server.io"
	pendrive -d file.ext or pendrive -d file.ext --server="server.io"
```

# Version
Beta 0.1

# Author
Written by Saumil Shah. <a href="https://hellosaumil.github.io"> https://hellosaumil.github.io </a>
<br> More details about this project can be found at : <a href="https://github.com/hellosaumil/PenDrive"> https://github.com/hellosaumil/PenDrive </a>

# Reporintg Bugs
Report bugs to <a href="https://github.com/hellosaumil/PenDrive/issues"> https://github.com/hellosaumil/PenDrive/issues </a>
