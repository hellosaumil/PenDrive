# PenDrive
One-Click Command-Line Utility for file-sharing just for Developers!
<br>
[Download just ONE file!](setup)
<br>

```shell
	sh setup                	# Setup PenDrive with just ONE Hit!
```
# Man Page like Description

<h2 style="color:tomato"> Name </h2>
pendrive - A Command-Line Utility to upload/download files like PenDrive on Cloud

<h2> Synopsis </h2>
	pendrive [OPTION]... [FILE]... [SERVER]...

<h2> Description </h2>
A Simple Command-Line Utility for file sharing without the hassle of finding a pendrive nearby.
	You can transfer files with your Developer Friends with just ONE LINE !!!
	Upload / Download Files at your leisure with PenDrive Cloud. Share all kinds of files, be it programs, text files, images & videos.
	Just need an Internet Connection and you're Good to Go!
	Days of carying flashdrives are gone!
	Happy File Sharing!

<h2> Options </h2>
Describes all Options of PenDrive on Cloud

		-l		Option for Listing available files on PenDrive Cloud

		-u		Upload a File to PenDrive Cloud by providing a filename after -u option

		-d		Download a File from PenDrive Cloud by providing a filename after -d option

		-h		Provides help on how to use the pendrive command-line utility

		--server	User can provide servername explicitly as --server=["example.server-address.com"]		

<h2> Usage </h2>
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
<h2> Examples </h2>
``` shell
	pendrive
	pendrive -h
	pendrive -l or pendrive -l --server="server.io"
	pendrive -u file.ext or pendrive -u file.ext --server="server.io"
	pendrive -d file.ext or pendrive -d file.ext --server="server.io"
```

<h2> Version </h2>
Beta 0.1

<h2> Author </h2>
Written by Saumil Shah. <a href="https://hellosaumil.github.io"> https://hellosaumil.github.io </a>
<br> More details about this project can be found at : <a href="https://github.com/hellosaumil/PenDrive"> https://github.com/hellosaumil/PenDrive </a>
<br>
[Download source code here!](src/pendrive)

<h2> Reporintg Bugs </h2>
Report bugs to <a href="https://github.com/hellosaumil/PenDrive/issues"> https://github.com/hellosaumil/PenDrive/issues </a>
