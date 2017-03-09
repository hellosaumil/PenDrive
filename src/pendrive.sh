#@(#)Code for Web Pendrive. Developed By: Saumil Shah"

clear

server="https://97f8b9d7.ngrok.io"

if [ $# -gt 0 ]
then
  flag="$arr"
  server_flag="found"
  fname_len="${#1}"
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
          if [ $# -gt 1 -a "$server_flag" == "-none" ]
          then
               printf "\n\e[1;31mUnncessary Arguments after -l\e[0m"
               printf "\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
               printf "\n\e[1;96mUsage: pendrive -l\n\e[0m"
               exit 101
          fi

          printf "\nIn List Mode :"
          printf "\nAvailable Files : "
          curl -X GET "$server"

          printf "\n"

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
          fileX=$2
          s=`echo "$fileX" | grep "server"`
          if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
          then
               file=`basename ${fileX}`
               loc=`dirname ${fileX}`

               printf "\nSending file : $file"
               printf "\nLocated at : "
               if [ "$loc" == "." -o "$loc" == ".." ]
               then
                    loc=`pwd $(dirname ${fileX})`
                    printf "$loc\n"
               else
                    printf "$loc\n"
               fi

               if [ -f "$full" ];
               then
                    echo "Do";
               else
                    echo "Don't";
               fi

          #      status=`curl -s -X POST --form "sharingType=upload" --form "fileName=$file" --form "data=@$fileX" "$server/pendrive"`
          #      printf "\n\e[1;96m$status\e[0m"

          else
               printf "\n\e[1;31mInvalid File Name Provided...!\e[0m"
          fi

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
               printf "\nRequesting file : $file\n"
               mkdir -p ~/PenDrive
               x=`echo ~`
               full=`echo "$x/PenDrive/$file"`
               curl -s -X POST --form "sharingType=download" --form "fileName=$file" "$server/pendrive" --output $full

               s=`cat "$full" | grep "INFC"`
               if [ "$s" == " " -o "$s" == "" ]
               then
                    printf "\n\e[1;96mFile Downloaded...!!!\e[0m"
                    printf "\n\nFile can be found at : \e[1;3;163m$full\e[0m"
               else
                    printf "\n\e[1;31mInvalid File Name Requested...!\e[0m"
                    rm -rf $full
               fi
          else
               printf "\n\e[1;31mInvalid File Name Provided...!\e[0m"
          fi

     elif [ $1 == "-r" ]
     then
          if [ $# -lt 2 -o $# -gt 2 -a "$server_flag" == "-none" ]
          then
               printf "\n\e[1;31mInsufficient Arguments for -r\e[0m"
               printf "\n\e[1;96mUsage: pendrive [OPTION] [FILE]\e[0m"
               printf "\n\e[1;96mUsage: pendrive -r filename\n\e[0m"
               exit 103
          fi

          printf "\nIn Remove Mode : "
          printf "\t\e[1;31mBE CAUTIOUS\e[0m"
          file=$2

          s=`echo "$file" | grep "server"`
          if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
          then
               printf "\nRequesting to remove file : $file\n"
               mkdir -p ~/PenDrive
               x=`echo ~`
               full=`echo "$x/PenDrive/$file"`

               status=`curl -sX POST --form "sharingType=remove" --form "fileName=$file" "$server/pendrive"`
               s=`echo "$status" | grep "INFC"`
               if [ "$s" == " " -o "$s" == "" ]
               then
                    printf "\n\e[1;96mFile Removed...!!!\e[0m"
               else
                    printf "\n\e[1;31mInvalid File Name Requested to remove...!\e[0m"
               fi
          else
               printf "\n\e[1;31mInvalid File Name Provided...!\e[0m"
          fi

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
     printf "\n\tpendrive - One-Click Command-Line Utility for file-sharing just for Developers!"
     printf "\n\tA Command-Line Utility to upload/download files like a PenDrive\n"

     printf "\n\e[1;163mSYNOPSIS\e[0m"
     printf "\n\t\e[1;163mpendrive\e[0m"
     printf " [OPTION]... [FILE]... [SERVER]..."

     printf "\n\n\e[1;163mDESCRIPTIONS\e[0m"
     printf "\n\tA Simple \e[1;164mCommand-Line Utility\e[0m for file sharing\e[1;3;163m without the hassle\e[0m of finding a pendrive nearby."
     printf "\n\tYou can transfer files with your \e[1;3;163mDeveloper\e[0m Friends with just "
     printf "\e[1;163mONE LINE\e[0m"
     printf " !!!"
     printf "\n\tUpload / Download Files at your leisure with PenDrive Cloud."
     printf " Share all kinds of files, be it \e[1;3;163mprograms, text files, images & videos.\e[0m"

     printf "\n\tJust need an Internet Connection and you're Good to Go!"
     printf "\n\tDays of carying flashdrives are gone!"

     printf "\n\tHappy File Sharing!"

     printf "\n\n\e[1;163mOPTIONS\e[0m"
     printf "\n\t Describes all Options of PenDrive on Cloud\n"

     printf "\n\t\t\e[1;163m-l\e[0m"
     printf "\t Option for Listing available files on PenDrive Cloud"

     printf "\n\n\t\t\e[1;163m-u\e[0m"
     printf "\t Upload a File to PenDrive Cloud by providing a filename after \e[1;163m-u\e[0m option"

     printf "\n\n\t\t\e[1;163m-d\e[0m"
     printf "\t Download a File from PenDrive Cloud by providing a filename after \e[1;163m-d\e[0m option"

     printf "\n\n\t\t\e[1;163m-h\e[0m"
     printf "\t Provides help on how to use the pendrive command-line utility"

     printf "\n\n\t\t\e[1;3;163m--server\e[0m"
     printf " User can provide servername explicitly as \e[1;3;163m--server=\e[0m\e[3m[\"example.server-address.com\"]\e[0m"

     printf "\n\n\e[1;163mUSAGE\e[0m"
     printf "\n\tpendrive                \t# Displays Man Page of pendrive"
     printf "\n\tpendrive   -l           \t# Lists all files on PenDrive Cloud"
     printf "\n\tpendrive   -u   file.ext\t# Upload a file to PenDrive Cloud"
     printf "\n\tpendrive   -d   file.ext\t# Download a file from PenDrive Cloud"
     printf "\n\tpendrive   -h           \t# Provides Help for using PenDrive Cloud"

     printf "\n\nalternatively,\n"
     printf "\n\tpendrive   -l              \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Lists all files on user-specified PenDrive Cloud Server"
     printf "\n\tpendrive   -u   file.ext   \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Upload a file to user-specified PenDrive Cloud Server"
     printf "\n\tpendrive   -d   file.ext   \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Download a file from user-specified PenDrive Cloud Server"


     printf "\n\n\e[1;163mVERSION\e[0m"
     printf "\n\t\e[3;7mBeta\e[0m"
     printf " 0.1"

     printf "\n\n\e[1;163mAUTHOR\e[0m"
     printf "\n\tWritten by Saumil Shah."
     printf "\n\tMore details about this project can be found at : "
     printf "\e[3;4mhttps://github.com/hellosaumil/PenDrive\e[0m"

     printf "\n\n\e[1;163mREPORTING BUGS\e[0m"
     printf "\n\tReport bugs to "
     printf "\e[3;4mhttps://github.com/hellosaumil/PenDrive/issues\e[0m"

     printf "\n"
fi
printf "\n"