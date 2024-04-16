#!/bin/sh

echo $REBUILD

# Check for battery > 90% on laptops
battery="/sys/class/power_supply/BAT1"
status="$(cat "$battery/status")"
capacity="$(cat "$battery/capacity")"

if [ $? -gt 0 ] || [ $capacity -gt 90 ] || [ $status = "Charging" ]; then
	echo "Valid for update, battery was at $capacity% and $status"
	cd /etc/nixos
	echo "Updating flake..."
	nix flake update --include /etc/nixos
	
	if ! sudo -u alikay git diff --quiet flake.lock
	then
		echo "Rebuilding the system"
		$REBUILD boot --flake /etc/nixos#alikay
		cd /home/alikay/dotfiles/nixos
		rm flake.lock
		cp /etc/nixos/flake.lock flake.lock
		chown alikay:users flake.lock
		
		echo "Commiting to repo"
		sudo -u alikay git add flake.lock
		sudo -u alikay git commit -m "Automatic Update to flake.lock"
	else
		echo "There were no changes to flake lock, so update was skipped..."
	fi
else
	echo "Skipped update, battery was at $capacity% and $status"
fi


