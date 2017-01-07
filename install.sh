#!/bin/bash
loadkeys fr &> /dev/null
if ping -c 1 195.238.2.21 &> /dev/null
then
	echo "No need for a configuration, you are already connected to the internet !"
else
	echo "We need to configure your internet connection."
fi

