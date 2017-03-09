clear
rm -rf ~/.PenDrive
mkdir -p ~/.PenDrive

printf "\nSetting Up PenDrive"
printf "\n\nDownloading PenDrive..."
x=`echo ~`
full=`echo "$x/.PenDrive/pendrive"`
curl -s https://raw.githubusercontent.com/hellosaumil/PenDrive/master/pendrive --output $full
printf "\n\nPenDrive Downloaded!"

flag="-none"
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
               chmod +x ~/.PenDrive/pendrive
			printf "\n\nAlias created as \e[1;3;163mpendrive \e[0m"
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
			chmod +x ~/.PenDrive/pendrive

               printf "\n\nAlias created as \e[1;3;163mpendrive \e[0m"

			;;
	*)		printf "\nUnknown OS-Type: $OSTYPE"
esac

if [ flag != "-none" ]
then
     printf "\n\e[1;163mSYNOPSIS\e[0m"
          printf "\n\t\e[1;163mpendrive\e[0m"
          printf " [OPTION]... [FILE]... [SERVER]..."

     printf "\n\nOpen New Tab see it in Action!"
     printf "\n\nPenDrive SetUp Successfully !!!\n"
else
     printf "\n\nError in setting up PenDrive"
     printf "\n\tReport bugs to "
     printf "\e[3;4mhttps://github.com/hellosaumil/PenDrive/issues\e[0m"
fi