#!/bin/sh

echo $REBUILD
OUTPUTPIPE=/home/alikay/.upgrade-script-pipe
LOCK_FILE=/home/alikay/.nixos-system-update-lock

#echo "Using dbus session: "
#echo $DBUS_SESSION_BUS_ADDRESS

# Wait for lock to be released
if [ -f "$LOCK_FILE" ]; then
	echo "Waiting for lock file at $LOCK_FILE to be free before updating..." > "$OUTPUTPIPE"
	echo "Waiting for lock file at $LOCK_FILE"
fi

while [ -f "$LOCK_FILE" ]
do
	sleep 1
done

# Create lock file
touch "$LOCK_FILE"

# Start the notifier service
#sudo -u alikay systemctl --user start auto-update-notify-watcher.service

# Check for battery > 90% on laptops
battery="/sys/class/power_supply/BAT1"
status="$(cat "$battery/status")"
capacity="$(cat "$battery/capacity")"

if [ $? -gt 0 ] || [ $capacity -gt 75 ] || [ $status = "Charging" ]; then
	echo "Valid for update, battery was at $capacity% and $status"
	cd /etc/nixos
	echo "Running automatic NixOS upgrade" > "$OUTPUTPIPE"
	echo "Updating flake..."
	nix flake update --include /etc/nixos

	cd /home/alikay/dotfiles
	rm flake.lock
	cp /etc/nixos/flake.lock flake.lock
	chown alikay:users flake.lock
	if ! sudo -u alikay git diff --quiet flake.lock
	then
		echo "Rebuilding the system..." > "$OUTPUTPIPE"
		echo "Rebuilding the system"
		$REBUILD boot --flake /etc/nixos#alikay

		if [ $? -eq 0 ]; then
			echo "Finding current NixOS Generation"
			gen=$("$REBUILD" list-generations | grep current | awk '{print $1;}')
			echo "Commiting to repo"
			sudo -u alikay git add flake.lock
			sudo -u alikay git commit -m "Automatic Update. Generation $gen"

			echo "Updates finished. They will be applied after the next reboot" > "$OUTPUTPIPE"
			echo "Updates finished"
		else
			echo "Rebuilding the system failed! Check logs for details." > "$OUTPUTPIPE"
			echo "Updates failed to apply."
		fi

	else
		echo "There were no changes to flake.lock, so auto update was skipped..." > "$OUTPUTPIPE"
		echo "There were no changes to flake lock, so update was skipped..."
	fi
else
	echo "Update was skipped due to insufficient battery. Battery was at $capacity% and $status" > "$OUTPUTPIPE"
	echo "Skipped update, battery was at $capacity% and $status"
fi

# Delete lock file
rm "$LOCK_FILE"

# Stop the notifier service
#sudo -u alikay systemctl --user stop auto-update-notify-watcher.service
