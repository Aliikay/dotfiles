#!/bin/sh

LOCK_FILE=/home/alikay/.nixos-system-update-lock

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

cd /home/alikay/dotfiles
gnome-text-editor nixos/configuration.nix flake.nix nixos/alikay-home.nix nixos/guest-home.nix
# Add any new files to git to be tracked
git status
git --no-pager diff

askYesNo "Would you like to apply this configuration?" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then
	askYesNo "Update the flake inputs as well?" true
	DOIT=$ANSWER
	
	# Wait for lock to be released
	while [ -f "$LOCK_FILE" ]
	do
		sleep 1
		printf "Waiting for the lock file at $LOCK_FILE \033[0K\r"
	done

	echo ""
	echo "No current lock file, locking changes..."

	# Create lock file
	sudo touch "$LOCK_FILE"
	
	if [ "$DOIT" = true ]; then
		echo "Updating main flake..."
		cd /home/alikay/dotfiles
		nix flake update
		echo "Updating secrets flake..."
		cd /home/alikay/dotfile-secrets
		nix flake update
	fi
	cd /home/alikay/dotfiles
	echo "Adding files to git"
	git add *
	echo "Delete old backup of /etc/nixos"
	sudo rm -r /etc/nixos.last
	echo "Moving last /etc/nixos to a backup"
	sudo mv /etc/nixos /etc/nixos.last
	echo "Copying in dotfiles to /etc/nixos"
	sudo cp -r /home/alikay/dotfiles /etc/nixos
	echo "Rebuilding the system..."
	nh os switch /home/alikay/dotfiles --hostname alikay
	
	# Remove lock file
	sudo rm "$LOCK_FILE"
	
	if [ $? = 0 ]
	then
		askYesNo "Commit these changes?" true
		DOIT=$ANSWER
		if [ "$DOIT" = true ]; then
			echo "Finding NixOS Generation Number"
			gen=$(nixos-rebuild list-generations  | grep current | awk '{print $1;}')
			echo "Comitting files to repo"
			git add *
			git commit -m "Auto commit from manual change: Generation $gen"
			echo "Pushing..."
			git push
		fi
	fi
	
fi
