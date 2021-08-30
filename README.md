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
| terminus | The Pantheon CLI — a standalone utility for performing operations on the Pantheon Platform | 2021-08-25 | 2.6.1 |
| balena_etcher | Flash OS images to SD cards & USB drives, safely and easily. | 2021-08-23 | 1.5.121-1 |
| gtk4 | GTK+ is a multi-platform toolkit for creating graphical user interfaces. | 2021-08-22 | 4.4.0 |
| glib | GLib provides the core application building blocks for libraries and applications written in C. | 2021-08-22 | 2.69.2 |
| atom | The hackable text editor | 2021-08-21 | 1.58.0-1 |
| vulkan_icd_loader | Vulkan Installable Client Driver ICD Loader | 2021-08-20 | 1.2.189 |
| vulkan_headers | Vulkan header files | 2021-08-20 | 1.2.189 |
| mesa | Open-source implementation of the OpenGL specification | 2021-08-20 | 21.2.1 |
| upx | Extendable, high-performance executable packer for several executable formats | 2021-08-19 | 4.0.0-8a82 |
| qtbase | Qt Base (Core, Gui, Widgets, Network, ...) | 2021-08-19 | 5.15.3 |

Latest Packages
---------------

| Name | Description | Date Added |
|:---|:---|:---|
| git_prompt | Display the git branch and status in the command prompt | 2021-08-26 |
| acli | Acquia CLI - The official command-line tool for interacting with the Drupal Cloud Platform and services. | 2021-08-25 |
| apktool | A tool for reverse engineering Android apk files | 2021-08-20 |
| teams | Microsoft Teams - Meet, chat, call, and collaborate in just one place. | 2021-08-15 |
| github_desktop | GitHub Desktop is an open source Electron-based GitHub app | 2021-08-15 |
| py3_secretstorage | Python bindings to Freedesktop.org Secret Service API | 2021-07-29 |
| py3_openssl | PyOpenSSL is a Python wrapper module around the OpenSSL library. | 2021-07-29 |
| py3_oci | Oracle Cloud Infrastructure Python SDK | 2021-07-29 |
| py3_keyring | Keyring stores and accesses your passwords safely. | 2021-07-29 |
| py3_impacket | Impacket provides network protocols constructors and dissectors. | 2021-07-29 |

Chat with us!
-------------
<p><em>Discord is not currently syncing messages with Slack</em></p>
<p><a href="https://join.slack.com/t/chromebrew/shared_invite/enQtNDA2MTQ5ODQ3NDc2LTA0ZmJlMGFmNmZhOTYwNDE3ZDY0NDA0MWI0OTE3MzJkYTQxN2UxMWQ1YTEzOWFmNTliMGM4NDZjYzY2NjczZGE" target="_blank"><img src="/images/slack.png" alt="Slack Invite" />
<a href="https://discord.gg/QRrzBXN" target="_blank"><img src="/images/discord.png" alt="Discord Invite" /></a></p>

License
-------

Copyright 2013-2021 Michal Siwek and [all the awesome contributors](https://github.com/skycocker/chromebrew/graphs/contributors).

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt).
