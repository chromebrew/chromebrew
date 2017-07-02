chromebrew
==========

Package manager for Chrome OS

Supported Systems
-----------------

| Architecture | Supported? |
|:---:|:---:|
| x86_64 | Yes |
| i686 | Yes |
| armv7l | Yes |
| aarch64 | Yes (use armv7l binaries) |

Here, I'm releasing personally modified chromebrew.  Modifications are listed at
[below](#modifications). If you are looking for the original chromebrew, please
refer [the original site](https://github.com/skycocker/chromebrew/).

Basically, I want to merge all modifications here to the original one.
So, this chromebrew often rebase to the original one to make merging
easier.

Overview
--------

Chromebooks with Chrome OS run a Linux kernel. The only missing pieces to use them as full-featured Linux distro were gcc and make with their dependencies. Well, these pieces aren't missing anymore. Say hello to chromebrew!

Prerequisites
-------------

You will need a Chromebook with developer mode enabled.

On [the ChromiumOS Wiki](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices) select your device and follow the instructions listed there.

Please be aware of the fact that developer mode is insecure if not properly configured.

Installation
------------
Open the terminal with Ctrl+Alt+T and type `shell`.

If this command returns `ERROR: unknown command: shell` please have a second look at the prerequisites and make sure your Chromebook is in developer mode.

Then download and run the installation script below:

    wget -q -O - https://raw.github.com/jam7/chromebrew/master/install.sh | bash

Usage
-----

    crew <command> <package> <keep[temporary files]>

Where available commands are:

  * build [build a package from source and store the archive and checksum in the current working directory]
  * binstall [build and install a package from source and store the archive and checksum in the current working directory]
  * download [download a package to `CREW_BREW_DIR` (`/usr/local/tmp/crew` by default), but don't install it]
  * help [get information about command usage]
  * install [install a package along with its dependencies after prompting for confirmation]
  * remove [remove a package]
  * search [look for a package]
  * update [update crew itself]
  * upgrade [update all or a specific package]
  * whatprovides [regex search for package(s) that contains file(s)]

Available packages are listed in the [packages directory](https://github.com/jam7/chromebrew/tree/master/packages).

Chromebrew will wipe its `BREW_DIR` (`/usr/local/tmp/crew` by default) after installation unless you pass "keep" as the last parameter when running "crew install".

    crew install <package> keep

Modifications
-------------

Chromebrew at this repository is modified from its original, https://github.com/skycocker/chromebrew.
I'll merge these modifications to the original, but it's time consuming.

What modifications are:

  * Refactoring crew
    * Add binstall (build and install)
    * Clean working directory before source extraction

License
-------

Copyright 2013 Michal Siwek and [all the awesome contributors](https://github.com/skycocker/chromebrew/graphs/contributors).  
Copyright 2016-2017 Kazushi (Jam) Marukawa, added ARM related packages.

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt).

Thanks Davy for [putting pre-compiled gcc for ARM](http://davy.nyacom.net/cros-arm-dev.html).  It was the beginning of chromebrew for ARM.
