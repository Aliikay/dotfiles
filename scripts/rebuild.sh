#!/bin/sh

function askYesNo {
        QUESTION=$1
        DEFAULT=$2
        if [ "$DEFAULT" = true ]; then
                OPTIONS="[Y/n]"
                DEFAULT="y"
            else
                OPTIONS="[y/N]"
                DEFAULT="n"
        fi
        read -p "$QUESTION $OPTIONS " -n 1 -s -r INPUT
        INPUT=${INPUT:-${DEFAULT}}
        echo ${INPUT}
        if [[ "$INPUT" =~ ^[yY]$ ]]; then
            ANSWER=true
        else
            ANSWER=false
        fi
}

cd ~/dotfiles
gedit nixos/configuration.nix
git status
git diff nixos/configuration.nix

askYesNo "Would you like to apply this configuration?" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then
	echo "Delete old backup of /etc/nixos"
	sudo rm -r /etc/nixos.last
	echo "Moving last /etc/nixos to a backup"
	sudo mv /etc/nixos /etc/nixos.last
	echo "Copying in dotfiles/nixos to /etc/nixos"
	sudo cp -r /home/alikay/dotfiles/nixos /etc/nixos
	echo "Rebuilding the system..."
	sudo nixos-rebuild switch
	
	if [ $? = 0 ]
	then
		askYesNo "Commit these changes?" true
		DOIT=$ANSWER
		if [ "$DOIT" = true ]; then
			git add *
			git commit -m "Automatic commit from rebuild script"
			git push
		fi
	fi
	
fi