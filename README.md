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

    sudo crew <command> <package>

Where available commands are:
  
  * search [looks for a package]
  * download [downloads a package to CREW_BREW_DIR(/usr/local/tmp/cbrew by default), but doesn't install it]
  * install [installs a package along with its dependencies. You'll be prompted for confirmation, must be ran as root]
  * remove [removes a package. Must be ran as root]
  
Available packages are listed in the [packages directory](https://github.com/skycocker/chromebrew/tree/master/packages). 
