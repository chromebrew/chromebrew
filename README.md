<p align="center"><img src="/images/brew.png" alt="Chromebrew logo" /></p>

<h1 align="center">Chromebrew</h1>

<p align="center">Package manager for Chrome OS</p>

Overview
--------

Chromebooks with Chrome OS run a Linux kernel. The only missing pieces to use them as full-featured Linux distro were gcc and make with their dependencies. Well, these pieces aren't missing anymore. Say hello to Chromebrew!

Prerequisites
-------------

You will need a Chromebook with developer mode enabled.  To do so, select your device on
[the ChromiumOS Wiki](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices) and follow the instructions listed there.

Please be aware of the fact that developer mode is insecure if not properly configured. Setting a password as instructed in the VT-2 login screen is essential. It is also recommended to enable signed boot:

```bash
sudo chromeos-setdevpasswd
sudo crossystem dev_boot_signed_only=1
```

Supported Systems
-----------------

| Architecture | Supported? |
|:---:|:---:|
| x86_64 | Yes |
| i686 | Yes<sup>*</sup> |
| armv7l | Yes |
| aarch64 | Yes |

<sup>*</sup> <em>We can only provide limited support for i686 since Google has discontinued support.  Although we can no longer support gui apps, we will try to continue to support cli programs.</em>

Installation
------------

The beta, dev, and Canary channels are ***not*** supported and should ***not*** be used with Chromebrew.
Failure to take notice of this will cause major issues with your Chromebrew installation.
See issue [#2890](https://github.com/skycocker/chromebrew/issues/2890) and the [FAQ](https://github.com/skycocker/chromebrew/wiki/FAQ) for more details.

Open the terminal with Ctrl+Alt+T and type `shell`.

If this command returns `ERROR: unknown command: shell`, please have a second look at the prerequisites and make sure your Chromebook is in developer mode.

Then download and run the installation script below:

    curl -Ls git.io/vddgY | bash

On a rooted Google OnHub, the command needs to be run with the "chronos" user. In order to make su work, a password is needed for the chronos user.

    # passwd chronos
    Changing password for chronos.
    Enter new UNIX password:
    Retype new UNIX password:
    # su - chronos
    Password:
    $ curl -Ls git.io/vddgY | bash

Help
----

Please check out the [wiki](https://github.com/skycocker/chromebrew/wiki) to find out more information about Chromebrew including helpful tips, resource links and frequently asked questions. Also please check existing [issues](https://github.com/skycocker/chromebrew/issues) before submitting a new one.

Usage
-----

    crew <command> [-k|--keep] <package1> [<package2> ...]

Where available commands are:

| Command | Description |
|:---|:---|
| build | build package(s) from source and store the archive and checksum in the current working directory |
| const | display constant(s) |
| deps | display dependencies of package(s) |
| download | download package(s) to CREW_BREW_DIR (/usr/local/tmp/crew by default), but don't install |
| files | display installed files of package(s) |
| help | get information about command usage |
| install | install package(s) along with dependencies after prompting for confirmation |
| list | available, installed, compatible or incompatible packages |
| postinstall | display postinstall messages of package(s) |
| reinstall | remove and install package(s) |
| remove | remove package(s) |
| search | look for package(s) |
| update | update crew itself |
| upgrade | update all or specific package(s) |
| whatprovides | regex search for package(s) that contains file(s) |

Available packages are listed in the [packages directory](https://github.com/skycocker/chromebrew/tree/master/packages).

Chromebrew will wipe its `BREW_DIR` (`/usr/local/tmp/crew` by default) after installation unless you pass `-k` or `--keep` when running `crew install`.

    crew install --keep <package1> [<package2> ...]

Recently Upgraded Packages
--------------------------

| Name | Description | Date Upgraded | Version |
|:---|:---|:---|:---|
| gdb | The GNU Debugger | 2021-09-25 | 11.1 |
| llvm | The LLVM Project is a collection of modular and reusable compiler and toolchain technologies. | 2021-09-24 | 12.0.1 |
| binutils | The GNU Binutils are a collection of binary tools. | 2021-09-24 | 2.37-1 |
| inetutils | The Inetutils package contains programs for basic networking. | 2021-09-24 | 2.2 |
| elfutils | elfutils is a collection of utilities and libraries to read, create and modify ELF binary files | 2021-09-24 | 0.185 |
| neon | neon is an HTTP and WebDAV client library, with a C interface. | 2021-09-24 | 0.32.1 |
| pango | Pango is a library for laying out and rendering of text, with an emphasis on internationalization. | 2021-09-24 | 1.49.1 |
| libadwaita | Library of GNOME-specific UI patterns, replacing libhandy for GTK4 | 2021-09-24 | 1.0.0-alpha.2 |
| gtksourceview_5 | Source code editing widget | 2021-09-24 | 5.2.0 |
| gspell | A flexible API to implement the spell checking in a GTK+ application | 2021-09-24 | 1.9.1-2 |

Latest Packages
---------------

| Name | Description | Date Added |
|:---|:---|:---|
| gnu_time | Utility for monitoring a programs use of system resources | 2021-09-24 |
| gnome_text_editor | GNOME Text Editor (2021) | 2021-09-24 |
| vuze | Vuze (formerly Azureus) is an extremely powerful and configurable BitTorrent client. | 2021-09-21 |
| smallbasic | SmallBASIC is a fast and easy to learn BASIC language interpreter | 2021-09-19 |
| logisim | An educational tool for designing and simulating digital logic circuits | 2021-09-16 |
| cros_adapta | Gtk+ compatible themes for styling UI elements from Crostini to match Chrome OS defaults. | 2021-09-10 |
| chafa | Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc. | 2021-09-04 |
| qtlocation | Qt Location and Positioning | 2021-08-30 |
| qtmultimedia | Qt Multimedia | 2021-08-30 |
| qtscript | Qt Script Tools | 2021-08-30 |

Chat with us!
-------------
<p><em>Discord is not currently syncing messages with Slack</em></p>
<p><a href="https://join.slack.com/t/chromebrew/shared_invite/enQtNDA2MTQ5ODQ3NDc2LTA0ZmJlMGFmNmZhOTYwNDE3ZDY0NDA0MWI0OTE3MzJkYTQxN2UxMWQ1YTEzOWFmNTliMGM4NDZjYzY2NjczZGE" target="_blank"><img src="/images/slack.png" alt="Slack Invite" />
<a href="https://discord.gg/QRrzBXN" target="_blank"><img src="/images/discord.png" alt="Discord Invite" /></a></p>

License
-------

Copyright 2013-2021 Michal Siwek and [all the awesome contributors](https://github.com/skycocker/chromebrew/graphs/contributors).

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt).
