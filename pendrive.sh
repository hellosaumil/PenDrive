#@(#)Code for Web Pendrive. Developed By: Saumil Shah"

clear

server="https://16f99dc9.ngrok.io"

if [ $# -gt 0 ]
then
  flag="$arr"
  server_flag="found"
  fname_len="${#1}"
  args="${arr:fname_len:x}"
  # printf "\n\e[1;96mArguments are Enabled...\e[0m"
  # printf "Your Arguments : $args"

     z=`echo "$@" | grep "server"`
     if [ ! -z "$z" -a "$z" != " " -a "$z" != "" ]
     then
          server=`echo $@ | cut -d " "  -f $# | cut -d "=" -f 2`
          printf "\n\nProvided Server : "$server
     else
          server_flag="-none"
      fi

else
 	flag="-none"
     # printf "\n\e[1;31mNo Arguments provided... :(\e[0m\n"
fi

printf "\n"

if [ "$flag" != "-none" ]
then
     if [ $1 == "-l" ]
     then
          printf "\nIn List Mode :"
          printf "\nAvailable Files : "
          curl -X GET "$server"

          printf "\n"
          if [ $# -gt 1 -a "$server_flag" == "-none" ]
          then
               printf "\n\e[1;31mUnncessary Arguments after -l\e[0m\n"
               printf "\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
               printf "\n\e[1;96mUsage: pendrive -l\n\e[0m"
               exit 101
          fi

     elif [ $1 == "-u" ]
     then
          if [ $# -lt 2 -o $# -gt 2 -a "$server_flag" == "-none" ]
          then
               printf "\n\e[1;31mInsufficient Arguments for -u\e[0m"
               printf "\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
               printf "\n\e[1;96mUsage: pendrive -u filename\n\e[0m"
               exit 102
          fi

          printf "\nIn Upload Mode : "
          file=$2
          s=`echo "$file" | grep "server"`
          if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
          then
               printf "\nSending file : $file\n\n"
               curl --form "sharingType=upload" --form "fileName=$file" --form "data=@$file" "$server"
          else
               printf "\n\e[1;31mInvalid File Name Provided...!\e[0m\n"
          fi

          printf "\n"

     elif [ $1 == "-d" ]
     then
          if [ $# -lt 2 -o $# -gt 2 -a "$server_flag" == "-none" ]
          then
               printf "\n\e[1;31mInsufficient Arguments for -d\e[0m"
               printf "\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
               printf "\n\e[1;96mUsage: pendrive -d filename\n\e[0m"
               exit 103
          fi

          printf "\nIn Download Mode : "
          file=$2

          s=`echo "$file" | grep "server"`
          if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
          then
               printf "\nReceiving file : $file\n"
               curl -X POST --form "sharingType=download" --form "fileName=$file" "$server" --output "./PenDrive/$file"

               printf "\nFile Downloaded...!!!"
          else
               printf "\n\e[1;31mInvalid File Name Provided...!\e[0m\n"
          fi

          printf "\n"

     elif [ $1 == "-h" ]
     then
          printf "\n\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
          printf "\nAlternatively, write"
          printf "\e[1;163m pendrive\e[0m"
          printf " in shell"

          printf "\n"
     else
          printf "\nUnexpected Mode...!!!"

     fi

else
     printf "\n\e[4;7mPenDrive CLI Utility\e[0m\n"

     printf "\e[1;163mNAME\e[0m"
     printf "\n\tpendrive - A Command-Line Utility to upload/download files like PenDrive on Cloud\n"

     printf "\n\e[1;163mUSAGE\e[0m"
     printf "\n\t\e[1;163mpendrive\e[0m"
     printf " [OPTION]... [FILE]... "

     printf "\n\n\e[1;163mDESCRIPTIONS\e[0m"
     printf "\n\tA Simple \e[1;164mCommand-Line Utility\e[0m for file sharing\e[1;3;163m without the hassle\e[0m of finding a pendrive nearby."
     printf "\n\tYou can transfer files with your Developer Friends with just "
     printf "\e[1;163mONE LINE\e[0m"
     printf " !!!"
     printf "\n\tUpload / Download Files at your leisure with PenDrive Cloud."
     printf " Share all kinds of files, be it \e[1;3;163mprograms, text files, images & videos.\e[0m"

     printf "\n\tJust need an Internet Connection and you're Good to Go!"
     printf "\n\tDays of carying flashdrives are gone!"

     printf "\n\tHappy File Sharing!"

     printf "\n\n\e[1;163mOPTIONS\e[0m"
     printf "\n\tDescribes all Options of PenDrive on Cloud\n"

     printf "\n\t\t\e[1;163m-l\e[0m"
     printf "\tOption for Listing available files on PenDrive Cloud"

     printf "\n\n\t\t\e[1;163m-u\e[0m"
     printf "\tUpload a File to PenDrive Cloud by providing a filename after \e[1;163m-u\e[0m option"

     printf "\n\n\t\t\e[1;163m-d\e[0m"
     printf "\tDownload a File from PenDrive Cloud by providing a filename after \e[1;163m-d\e[0m option"

     printf "\n\n\t\t\e[1;163m-h\e[0m"
     printf "\tProvides help on how to use the pendrive command-line utility"

     printf "\n\n\e[1;163mEXAMPLES\e[0m"
     printf "\n\tpendrive   -l           \t# Lists all files on PenDrive Cloud"
     printf "\n\tpendrive   -u   file.ext\t# Upload a file to PenDrive Cloud"
     printf "\n\tpendrive   -d   file.ext\t# Download a file from PenDrive Cloud"
     printf "\n\tpendrive   -h           \t# Provides Help for using PenDrive Cloud"

     printf "\n\n\e[1;163mVERSION\e[0m"
     printf "\n\tBeta "
     printf "\e[3;7m0.1\e[0m"

     printf "\n\n\e[1;163mAUTHOR\e[0m"
     printf "\n\tWritten by Saumil Shah."

     printf "\n\n\e[1;163mREPORTING BUGS\e[0m"
     printf "\n\tReport bugs to "
     printf "\e[3;4mmailto:hellosaumil@yahoo.com\e[0m"

     printf "\n"
fi
printf "\n"
