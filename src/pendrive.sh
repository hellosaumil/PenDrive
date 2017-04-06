#@(#)Code for Web Pendrive. Developed By: Saumil Shah"
clear

server="10.20.24.48:8080"

if [ $# -gt 0 ]
then
  flag="$arr"
  server_flag="found"
  fname_len="${#1}"

     z=`echo "$@" | grep "server"`
     if [ ! -z "$z" -a "$z" != " " -a "$z" != "" ]
     then
          server=`echo $@ | cut -d " "  -f $# | cut -d "=" -f 2`
          if [ "$server" != " " -a "$server" != "" ]
          then
               s=`echo "$server" | grep "server"`
               if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
               then
                    printf "\e[1;96mProvided Server : $server\t\e[0m"
               else
                    printf "\n\e[1;31mInvalid Server Name Provided!\n\e[0m"
                    printf "\n\e[1;96mUsage: pendrive [OPTION] [KEYWORD] --server=\"server.io:port\"\e[0m"
                    printf "\n\e[1;96mPossible KEYWORDs: FILE, TEXT, TOKEN \n\e[0m"

                    printf "\n\nAlternatively, write"
                    printf "\e[1;163m pendrive\e[0m"
                    printf " in shell for HELP\n"
                    exit 233
               fi
          else
               printf "\n\e[1;31mServer NOT Provided!\n\e[0m"
               exit 234
          fi

     else
          server_flag="-none"
          # printf "\n\n\e[1;96mDefault Server : $server\n\e[0m"
      fi
else
 	flag="-none"
     printf "\e[1;96mProviding Man Page\e[0m"
fi

x=`curl -sX GET "$server/life" | grep "Alive"`
s=`echo $x`

if [ "$s" != " " -a "$s" != "" ]
then
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
               printf "\e[3;96m `curl -sX GET "$server/pendrive"` \n\e[0m"

               printf "\n"

          elif [ $1 == "--upgrade" ]
          then
               if [ $# -gt 1 -a "$server_flag" == "-none" ]
               then
                    printf "\n\e[1;31mUnncessary Arguments after --upgrade\e[0m"
                    printf "\n\e[1;96mUsage: pendrive [OPTION] \e[0m"
                    printf "\n\e[1;96mUsage: pendrive --upgrade\n\e[0m"
                    exit 101
               fi

               clear
               printf "\nUpgrading..."

                    mkdir -p ~/.PenDrive

                    printf "\nSetting Up PenDrive"
                    printf "\n\nDownloading PenDrive..."
                    x=`echo ~`
                    full=`echo "$x/.PenDrive/pendrive-new"`
                    sudo curl -\# https://raw.githubusercontent.com/hellosaumil/PenDrive/master/src/pendrive --output $full
                    printf "\n\nPenDrive Downloaded!"

                    os_flag="-none"
                    case "$OSTYPE" in
                      linux*)
                    			printf "\nLinux\n"

                                   z=$(cat ~/.bashrc | grep "export PATH=\$PATH:~/.PenDrive/")
                                   if [ "$z" == " " -o "$z" == "" ];
                                   then
                                        printf "Aliasing..."
                                        printf "\nexport PATH=\$PATH:~/.PenDrive/" >> ~/.bashrc
                         			printf "\nalias pendrive=\"~/.PenDrive/pendrive\"" >> ~/.bashrc;
                                   else
                                        printf "Aliased!";
                                    fi

                                   source ~/.bashrc
                                   sudo chmod +x ~/.PenDrive/pendrive-new
                    			printf "\n\nAlias created as \e[1;3;163mpendrive \e[0m"
                                   os_flag=True
                    			;;
                      darwin*)
                    			printf "\nDarwin\n"
                                   z=$(cat ~/.bash_profile | grep "export PATH=\$PATH:~/.PenDrive/")
                                   if [ "$z" == " " -o "$z" == "" ];
                                   then
                                        printf "Aliasing..."
                                        printf "\nexport PATH=\$PATH:~/.PenDrive/" >> ~/.bash_profile
                         			printf "\nalias pendrive=\"~/.PenDrive/pendrive\"" >> ~/.bash_profile;
                                   else
                                        printf "Aliased!";
                                    fi

                                   source ~/.bash_profile
                    			sudo chmod +x ~/.PenDrive/pendrive-new

                                   printf "\n\nAlias created as \e[1;3;163mpendrive \e[0m"
                                   os_flag=True
                    			;;
                    	*)		printf "\nUnknown OS-Type: $OSTYPE"
                    esac

                    if [ os_flag != "-none" ]
                    then
                              printf "\n$os_flag\n\n"
                              printf "\n\e[1;163mSYNOPSIS\e[0m"
                              printf "\n\t\e[1;163mpendrive\e[0m"
                              printf " [OPTION]... [FILE]... [TEXT]... [TOKEN]... [SERVER]..."

                         printf "\n\nOpen New Tab see it in Action!"
                         printf "\n\nPenDrive SetUp Successfully !!!\n"

                         x=`echo ~`
                         full=`echo "$x/.PenDrive/pendrive"`
                         fullnew=`echo "$x/.PenDrive/pendrive-new"`
                         fullupdater=`echo "$x/.PenDrive/updater"`

                         echo 'sudo rm '$full'; sudo mv '$fullnew $full'; printf "\nUpdation Successfull!"' >> $fullupdater

                         sudo sh $fullupdater
                         sudo rm $fullupdater

                    else
                         printf "\n\nError in setting up PenDrive"
                         printf "\n\tReport bugs to "
                         printf "\e[3;4mhttps://github.com/hellosaumil/PenDrive/issues\e[0m"
                    fi


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

                    printf "\nSending file : "
                    printf "\e[3;96m$file\n\e[0m"
                    printf "Locating at... "

                    if [ "$loc" == "." -o "$loc" == ".." ]
                    then
                         loc=`pwd $(dirname ${fileX})`
                         printf "$loc/"
                         printf "\e[1;96m$file\n\e[0m"
                    else
                         printf "$loc/"
                         printf "\e[3;96m$file\e[0m"
                    fi

                    if [ -e "$fileX" ]
                    then
                         printf "\t $file located"
                         printf "\n\nUploading $file...\n"
                         status=`curl -s -X POST --form "sharingType=upload" --form "fileName=$file" --form "data=@$fileX" "$server/pendrive"`
                         printf "\n\e[1;96m$status\e[0m"
                    else
                         printf "\n\e[1;31mInvalid File Name Requested to upload...!\e[0m"
                    fi

               else
                    printf "\n\e[1;31mFile Name NOT Provided...!\e[0m"
               fi

          elif [ $1 == "-c" ]
          then
               if [ $# -lt 2 -a "$server_flag" == "-none" ]
               then
                    printf "\n\e[1;31mInsufficient Arguments for -c\e[0m"
                    printf "\n\e[1;96mUsage: pendrive [OPTION] [TEXT]\e[0m"
                    printf "\n\e[1;96mUsage: pendrive -c copyText\n\e[0m"
                    printf "and User will be asked to provide Token"
                    exit 102
               fi

               printf "\nIn Copy Mode : "
               copyX="${@:2:$(($#))}"

               s=`echo "$copyX" | grep "server"`
               if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
               then
                    copyX=""${@:2:$(($#-1))}""
               else
                    # printf "\n\e[1;31mServer Provided...!\e[0m"
                    copyX="${@:2:$(($#-2))}"
               fi

                    printf "\n\nSending text... "
                    printf "\e[3;96m$copyX\e[0m"

                    printf "\tProvide Token : "
                    read tokenX

                    status=`curl -sX POST --form "sharingType=copy" --form "fileName=$tokenX.txt" --form "data=${copyX}" "$server/pendrive"`
                    printf "\e[1;96m$status\e[0m"

                    s=`echo "$status" | grep "INFC"`
                    if [ "$s" == " " -o "$s" == "" ]
                    then
                         printf "\nUse Token "
                         printf "\e[1;96m$tokenX\e[0m"
                         printf " to Paste Content!\n\e[0m"

                         printf "\n\e[3mUsage: pendrive -p \e[0m"
                         printf "\e[3;96m$tokenX\e[0m"
                    else
                         printf "\n\e[1;31mCould not Share Data!\n\e[0m"
                    fi

          elif [ $1 == "-p" ]
          then
               if [ $# -lt 2 -o $# -gt 2 -a "$server_flag" == "-none" ]
               then
                    printf "\n\e[1;31mInsufficient Arguments for -p\e[0m"
                    printf "\n\e[1;96mUsage: pendrive [OPTION] [TOKEN]\e[0m"
                    printf "\n\e[1;96mUsage: pendrive -p pasteToken\n\e[0m"
                    exit 103
               fi

               printf "\nIn Paste Mode : "
               pasteX=$2

               s=`echo "$pasteX" | grep "server"`
               if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
               then

                    printf "\nRequesting text... "
                    printf "\t From Provided Token : "
                    printf "\e[3;96m$pasteX\n\e[0m"

                    status=`curl -sX POST --form "sharingType=paste" --form "fileName=$pasteX.txt" "$server/pendrive"`
                    # printf "\n\e[1;96m$status\e[0m"

                    s=`echo "$status" | grep "INFC"`
                    if [ "$s" == " " -o "$s" == "" ]
                    then
                         printf "\nYour Shared Text is... "
                         printf "\e[1;96m$status\e[0m"

                         printf "\n\n\e[3mUsage: pendrive -rp \e[0m"
                         printf "\e[3;96m$pasteX\e[0m\t to Remove This Token"
                    else
                         printf "\n\e[1;31mInvalid Paste Token Requested to copy...!\e[0m"
                    fi

               else
                    printf "\n\e[1;31mPaste Token NOT Provided...!\e[0m"
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
               fileX=$2

               s=`echo "$fileX" | grep "server"`
               if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
               then

                    file=`basename ${fileX}`
                    loc=`dirname ${fileX}`

                    printf "\nRequesting file : "
                    printf "\e[3;96m$file\n\e[0m"
                    mkdir -p ~/PenDrive
                    x=`echo ~`
                    full=`echo "$x/PenDrive/$file"`
                    curl -\#X POST --form "sharingType=download" --form "fileName=$file" "$server/pendrive" --output $full

                    s=`cat "$full" | grep "INFC"`
                    if [ "$s" == " " -o "$s" == "" ]
                    then
                         printf "\n\e[1;96mFile Downloaded...!!!\e[0m"
                         printf "\n\nFile can be found at : \e[1;3;163m$full\e[0m"
                    else
                         printf "\n\e[1;31mInvalid File Name Requested to download...!\e[0m"
                         printf "\n\n\e[1;96mTry Writing: pendrive -l to see available files\e[0m"
                         rm -rf $full
                    fi

               else
                    printf "\n\e[1;31mCan't Located File!\e[0m"
                    printf "\n\e[1;31mFile Name NOT Provided...!\e[0m"
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
                    printf "\nRequesting to remove file : "
                    printf "\e[3;96m$file\n\e[0m"

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

          elif [ $1 == "-rp" ]
          then
               if [ $# -lt 2 -o $# -gt 2 -a "$server_flag" == "-none" ]
               then
                    printf "\n\e[1;31mInsufficient Arguments for -rp\e[0m"
                    printf "\n\e[1;96mUsage: pendrive [OPTION] [TOKEN]\e[0m"
                    printf "\n\e[1;96mUsage: pendrive -rp pasteToken\n\e[0m"
                    exit 103
               fi

               printf "\nIn Remove Sharing Text Mode : "
               printf "\t\e[1;31mBE CAUTIOUS\e[0m"
               tokenX=$2

               s=`echo "$tokenX" | grep "server"`
               if [ -z "$s" -o "$s" == " " -o "$s" == "" ]
               then
                    printf "\nRequesting to remove pasteToken : "
                    printf "\e[3;96m$tokenX\n\e[0m"


                    status=`curl -sX POST --form "sharingType=removePaste" --form "fileName=$tokenX.txt" "$server/pendrive"`
                    s=`echo "$status" | grep "INFC"`
                    if [ "$s" == " " -o "$s" == "" ]
                    then
                         printf "\n\e[1;96mPaste Token Removed...!!!\e[0m"
                    else
                         printf "\n\e[1;31mInvalid Paste Token Requested to remove...!\e[0m"
                    fi
               else
                    printf "\n\e[1;31mInvalid Paste Token Provided...!\e[0m"
               fi

          elif [ $1 == "-h" ]
          then
               printf "\n\n\e[1;96mUsage: pendrive [OPTION] [KEYWORD]\e[0m"
               printf "\n\e[1;96mPossible KEYWORDs: OPTION, FILE, TEXT, TOKEN \n\e[0m"
               printf "\nAlternatively, write"
               printf "\e[1;163m pendrive\e[0m"
               printf " in shell"

               printf "\n"
          else
               printf "\n\e[1;31mUnexpected Mode...!!!\e[0m"
          fi
     else
          clear
               printf "\n\e[4;7mPenDrive CLI Utility\e[0m\n"

               printf "\e[1;163mNAME\e[0m"
               printf "\n\tpendrive - One-Click Command-Line Utility for file-sharing just for Developers!"
               printf "\n\tA Command-Line Utility to upload/download files like a PenDrive"
               printf "\twith added functionality of Copy & Paste.\n"

               printf "\n\e[1;163mSYNOPSIS\e[0m"
               printf "\n\t\e[1;163mpendrive\e[0m"
               printf " [OPTION]... [FILE]... [TEXT]... [TOKEN]... [SERVER]..."

               printf "\n\n\e[1;163mDESCRIPTIONS\e[0m"
               printf "\n\tA Simple \e[1;164mCommand-Line Utility\e[0m for file sharing\e[1;3;163m without the hassle\e[0m of finding a pendrive nearby."
               printf "\n\tYou can transfer files with your \e[1;3;163mDeveloper\e[0m Friends with just "
               printf "\e[1;163mONE LINE\e[0m"
               printf " !!!"
               printf "\n\n\tUpload / Download Files at your leisure with PenDrive Cloud."
               printf "\n\tShare all kinds of files, be it \e[1;3;163mprograms, text files, images & videos.\e[0m"
               printf "\n\tYou can also \e[1;3;163mCopy & Paste Text\e[0m without the hassle to mail!"

               printf "\n\n\tJust need an Internet Connection and you're Good to Go!"
               printf "\n\tDays of carrying flashdrives are gone!"

               printf "\n\tHappy File Sharing!"

               printf "\n\n\e[1;163mOPTIONS\e[0m"
               printf "\n\t Describes all Options of PenDrive on Cloud\n"

               printf "\n\t\t\e[1;163m-l\e[0m"
               printf "\t Option for Listing available files on PenDrive Cloud"

               printf "\n\n\t\t\e[1;163m-u\e[0m"
               printf "\t Upload a File to PenDrive Cloud by providing a filename after \e[1;163m-u\e[0m option"

               printf "\n\n\t\t\e[1;163m-d\e[0m"
               printf "\t Download a File from PenDrive Cloud by providing a filename after \e[1;163m-d\e[0m option"

               printf "\n\n\t\t\e[1;163m-c\e[0m"
               printf "\t Copy Text to PenDrive Cloud by providing text after \e[1;163m-c\e[0m option; "
               printf "User will be asked to provide a Token"

               printf "\n\n\t\t\e[1;163m-p\e[0m"
               printf "\t Paste Text from PenDrive Cloud by providing Paste Token after \e[1;163m-p\e[0m option"

               printf "\n\n\t\t\e[1;163m-d\e[0m"
               printf "\t Remove a File on PenDrive Cloud by providing a filename after \e[1;163m-r\e[0m option"

               printf "\n\n\t\t\e[1;163m-rp\e[0m"
               printf "\t Remove Shared Text from PenDrive Cloud by providing Paste Token after \e[1;163m-rp\e[0m option"

               printf "\n\n\t\t\e[1;163m-h\e[0m"
               printf "\t Provides help on how to use the pendrive command-line utility"

               printf "\n\n\t\t\e[1;3;163m--server\e[0m"
               printf " User can provide servername explicitly as \e[1;3;163m--server=\e[0m\e[3m[\"example.server-address.com\"]\e[0m"

               printf "\n\n\e[1;163mUSAGE\e[0m"
               printf "\n\tpendrive                \t# Displays Man Page of pendrive"
               printf "\n\tpendrive   --upgrade     \t# Upgrade PenDrive from Cloud"
               printf "\n\tpendrive   -l           \t# Lists all files on PenDrive Cloud"
               printf "\n"
               printf "\n\tpendrive   -u   file.ext\t# Upload a file to PenDrive Cloud"
               printf "\n\tpendrive   -d   file.ext\t# Download a file from PenDrive Cloud"
               printf "\n"
               printf "\n\tpendrive   -c   copyText\t# Copy Text to PenDrive Cloud with a user-specified Token"
               printf "\n\tpendrive   -p   pasteToken\t# Paste Text from PenDrive Cloud using a user-specified Token"
               printf "\n"
               printf "\n\tpendrive   -r   file.ext\t# Remove a file on PenDrive Cloud"
               printf "\n\tpendrive   -rp  pasteToken\t# Remove Shared Text from PenDrive Cloud using a user-specified Token"
               printf "\n"
               printf "\n\tpendrive   -h           \t# Provides Help for using PenDrive Cloud"

               printf "\n\nalternatively,\n"
               printf "\n\tpendrive   --upgrade        \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Upgrade PenDrive from Cloud"
               printf "\n\tpendrive   -l               \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Lists all files on user-specified PenDrive Cloud Server"
               printf "\n"
               printf "\n\tpendrive   -u   file.ext    \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Upload a file to user-specified PenDrive Cloud Server"
               printf "\n\tpendrive   -d   file.ext    \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Download a file from user-specified PenDrive Cloud Server"
               printf "\n"
               printf "\n\tpendrive   -c   copyText    \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Copy Text to user-specified PenDrive Cloud Server"
               printf "\n\tpendrive   -p   pasteToken  \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Paste Text from user-specified PenDrive Cloud Server"
               printf "\n"
               printf "\n\tpendrive   -r   file.ext    \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Remove a file on user-specified PenDrive Cloud Server"
               printf "\n\tpendrive   -rp  pasteToken  \e[1;3;163m--server=\e[0m\e[3m[\"server.io\"]\e[0m   \t# Remove Shared Text from user-specified PenDrive Cloud Server"

               printf "\n\n\e[1;163mVERSION\e[0m"
               printf "\n\t\e[3;7mBeta\e[0m"
               printf " 0.1.6.4.2017"

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

else
     printf "\n\n\e[1;31mCould Not Resolve Host\e[0m"
     printf " : $server/pendrive"
     printf "\nMake sure your Internet is working fine!\n"
     exit 404
fi
