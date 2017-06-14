chromebrew
==========

Package manager for Chrome OS

Supported Systems
-----------------

|  Architecture  | Supported? |
|:--------------:|:----------:|
|     x86_64     |     Yes    |
|      i686      |     Yes    |
| arm (Exynos 5) |     Yes    |

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

    wget -q -O - https://raw.github.com/skycocker/chromebrew/master/install.sh | bash

Usage
-----

    crew <command> <package> <keep[temporary files]>

Where available commands are:

  * build [build a package from source and store the archive and checksum in the current working directory]
  * download [download a package to `CREW_BREW_DIR` (`/usr/local/tmp/crew` by default), but don't install it]
  * help [get information about command usage]
  * install [install a package along with its dependencies after prompting for confirmation]
  * remove [remove a package]
  * search [look for a package]
  * update [update crew itself]
  * upgrade [update all or a specific package]
  * whatprovides [regex search for package(s) that contains file(s)]

Available packages are listed in the [packages directory](https://github.com/skycocker/chromebrew/tree/master/packages).

Chromebrew will wipe its `BREW_DIR` (`/usr/local/tmp/crew` by default) after installation unless you pass "keep" as the last parameter when running "crew install".

    crew install <package> keep

License
-------

Copyright 2013 Michal Siwek and [all the awesome contributors](https://github.com/skycocker/chromebrew/graphs/contributors).

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt).
