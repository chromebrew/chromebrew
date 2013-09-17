chromebrew
==========

Package manager for Chrome OS

Overview
--------

Chromebooks with Chrome OS run a linux kernel - the only missing piece to use them as full-featured linux distro was gcc and make with their dependencies. Well, the piece isn't missing anymore. Say hello to chromebrew!

Installation
------------

Download and run the installation script

    wget -q -O - https://raw.github.com/skycocker/chromebrew/master/install.sh | bash

Usage
-----

    sudo cbrew <command> <package>

Where available commands are:
  
  * search
  * download
  * install
  * remove
  
Available packages are listed in the [packages directory](https://github.com/skycocker/chromebrew/tree/master/packages). 
