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
gnome-text-editor nixos/configuration.nix flake.nix nixos/home.nix
git status
git --no-pager diff

askYesNo "Would you like to apply this configuration?" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then
	askYesNo "Update the flake inputs as well?" true
	DOIT=$ANSWER
	if [ "$DOIT" = true ]; then
		cd /home/alikay/dotfiles
		nix flake update
	fi
	echo "Delete old backup of /etc/nixos"
	sudo rm -r /etc/nixos.last
	echo "Moving last /etc/nixos to a backup"
	sudo mv /etc/nixos /etc/nixos.last
	echo "Copying in dotfiles to /etc/nixos"
	sudo cp -r /home/alikay/dotfiles /etc/nixos
	echo "Rebuilding the system..."
	nh os switch /home/alikay/dotfiles --hostname alikay
	
	if [ $? = 0 ]
	then
		askYesNo "Commit these changes?" true
		DOIT=$ANSWER
		if [ "$DOIT" = true ]; then
			echo "Finding NixOS Generation Number"
			gen=$(nixos-rebuild list-generations  | grep current | awk '{print $1;}')
			echo "Comitting files to repo"
			git add *
			git commit -m "Automatic commit: Generation $gen"
			echo "Pushing..."
			git push
		fi
	fi
	
fi
