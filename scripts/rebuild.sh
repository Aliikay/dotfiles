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

#gedit ~/dotfiles/nixos/configuration.nix

askYesNo "Would you like to apply this configuration?" true
DOIT=$ANSWER

if [ "$DOIT" = true ]; then
	sudo mv /etc/nixos /etc/nixos.last
	sudo cp /home/alikay/dotfiles/nixos /etc/nixos
	sudo nixos-rebuild switch
fi
