#!/bin/bash
loadkeys fr
if [ping -c 195.238.2.21]
then
	echo "Ping réussi !"
	echo "No need for a configuration, you are already connected to the internet !"
else
	echo "We need to configure your internet connection."
fi

