
# Chromebrew

![Chromebrew logo](/images/brew.png)

The Missing Package Manager For Chrome OS

## Chat With Us

_Discord is not currently syncing messages with Slack_

[![Slack Invite](https://cdn.bfldr.com/5H442O3W/at/pl546j-7le8zk-838dm2/Slack_RGB.png?auto=webp&format=png)](mailto:crewonslack@gmail.com?subject=Slack%20invitation%20link%20request&body=Auto-generated%20by%20README.md)

[![Discord Invite](https://discord.com/assets/ff41b628a47ef3141164bfedb04fb220.png)](https://discord.gg/QRrzBXN)

## Overview

Chromebooks with Chrome OS run a Linux kernel. The only missing pieces to use them as full-featured Linux distro were gcc and make with their dependencies. Well, these pieces aren't missing anymore. Say hello to Chromebrew!

## Prerequisites

You will need a Chromebook with developer mode enabled. To do so, select your device on [the ChromiumOS Wiki](https://www.chromium.org/chromium-os/developer-information-for-chrome-os-devices) and follow the instructions listed there. Please be aware of the fact that developer mode is insecure if not properly configured.

Setting a password as instructed in the VT-2 login screen is recommended. It is also recommended to enable signed boot:

```bash
sudo chromeos-setdevpasswd
sudo crossystem dev_boot_signed_only=1
```

## Supported Systems

| Architecture | Supported? |
|:---:|:---:|
| x86_64 | Yes |
| i686 | Yes\* |
| armv7l | Yes |
| aarch64 | Yes |

\* _We can only provide limited support for i686 since Google has discontinued support. Although we can no longer support GUI apps, we will try to continue to support CLI programs._

## Installation

The beta, dev, and Canary channels are ***not*** supported and should ***not*** be used with Chromebrew. Failure to take notice of this warning will cause major issues with your Chromebrew installation.

See issue [#2890](https://github.com/chromebrew/chromebrew/issues/2890) and the [FAQ](https://github.com/chromebrew/chromebrew/wiki/FAQ) for more details.

Open the terminal with Ctrl+Alt+T and type `shell`. If this command returns `ERROR: unknown command: shell`, please have a second look at the prerequisites and make sure your Chromebook is in developer mode.

Then download and run the installation script below:

```bash
curl -Ls git.io/vddgY | bash
```

On a rooted Google OnHub, the command needs to be run with the "chronos" user. In order to make su work, a password is needed for the chronos user.

```bash
# passwd chronos
Changing password for chronos.
Enter new UNIX password:
Retype new UNIX password:
# su - chronos
Password:
$ curl -Ls git.io/vddgY | bash
```

## Help

Please check out the [wiki](https://github.com/chromebrew/chromebrew/wiki) to find out more information about Chromebrew including helpful tips, resource links and frequently asked questions.

Also please check existing [issues](https://github.com/chromebrew/chromebrew/issues) before submitting a new one.

## Usage

```bash
crew [-k|--keep] [...]
```

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
| prop | display all package boolean properties |
| reinstall | remove and install package(s) |
| remove | remove package(s) |
| search | look for package(s) |
| sysinfo | show system information in markdown style |
| update | update crew itself |
| upgrade | update all or specific package(s) |
| whatprovides | regex search for package(s) that contains file(s) |

Available packages are listed in the [packages directory](https://github.com/chromebrew/chromebrew/tree/master/packages). Chromebrew will wipe its `BREW_DIR` (`/usr/local/tmp/crew` by default) after installation unless you pass `-k` or `--keep` when running `crew install`.

```bash
crew install --keep [...]
```

## License

Copyright 2013-2023 Michal Siwek and [all the awesome contributors](https://github.com/chromebrew/chromebrew/graphs/contributors). This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt). This project embeds [docopt.rb](https://github.com/docopt/docopt.rb) at lib/docopt.rb. We retain its [MIT license](https://github.com/chromebrew/chromebrew/blob/master/lib/docopt.LICENSE).

[![GNU General Public License](https://www.gnu.org/graphics/gplv3-127x51.png)](https://www.gnu.org/licenses/gpl-3.0.en.html)

[![MIT License](https://upload.wikimedia.org/wikipedia/commons/0/0c/MIT_logo.svg)](https://mit-license.org/)
