#!/bin/sh
# switches gtk theme globally

case "$1" in
	dark)
		MODE='prefer-dark';;
	light)
		MODE='prefer-light';;
	*)
		exit 1;;
esac

gsettings set org.gnome.desktop.interface color-scheme $MODE
