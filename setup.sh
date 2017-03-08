clear
rm -rf ~/.PenDrive
mkdir -p ~/.PenDrive

printf "\nSetting Up PenDrive"
printf "\n\nDownloading PenDrive...	"
wget -q https://github.com/hellosaumil/PenDrive/raw/master/src/pendrive -P ~/.PenDrive/
printf "\n\nPenDrive Downloaded!"

case "$OSTYPE" in
  linux*)
			printf "\nLinux\n"

               z=$(`cat ~/.bashrc | grep "export PATH=\$PATH:~/.PenDrive/"`)
               if [ "$z" != " " -o "$z" != "" ]
               then
                    printf "Aliasing..."
                    printf "\nexport PATH=\$PATH:~/.PenDrive/" >> ~/.bashrc
     			printf "\nalias pendrive=\"~/.PenDrive/pendrive\"" >> ~/.bashrc
               else
                    printf "Aliased!"
                fi

               source ~/.bashrc
               chmod +x ~/.PenDrive/pendrive
			printf "\n\nAlias created as \e[1;3;163mpendrive \e[0m"
			;;
  darwin*)
			printf "\nDarwin\n"
               z=$(cat ~/.bash_profile | grep -p "export PATH=\$PATH:~/.PenDrive/")
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

printf "\n\e[1;163mSYNOPSIS\e[0m"
     printf "\n\t\e[1;163mpendrive\e[0m"
     printf " [OPTION]... [FILE]... [SERVER]..."

printf "\n\nOpen New Tab see it in Action!"
printf "\n\nPenDrive SetUp Successfullly!!!\n"
