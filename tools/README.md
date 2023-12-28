# Tools

This directory contains a number of tools used to assist in the development of Chromebrew.

## Check for packages needing updates

These are a collection of scripts and files used to detect if packages need an update.
Coverage is spotty, and the majority of packages are unsuppported.

- `check.rb`
- `check_updates.sh`
- `compare_packages.sh`
- `core_packages.txt`
- `packages.yaml`

## Add missing dependencies to packages

This script adds missing dependencies to packages by checking their library dependencies and what crew package provides them.

- `getrealdeps.sh`

## Upload package binaries to GitLab

This script uploads built packages to GitLab, where we currently host precompiled binaries.

- `gl.sh`

## Valid licenses for packages

This file contains guidance on formatting conventions for what to put in the license field of packages.
There is also a rough list of what licenses are used, although this is incomplete and a little outdated.

- `licenses.txt`
