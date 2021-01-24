#!/bin/bash
#
# Usage: yes | bash generate_binaries.sh [directory] [start]
#
# [directory] Optional directory where the binaries will be stored.
#             If not provided, a directory relative to the current
#             directory will be created using the current date.
#
#     [start] Optional package name of the first binary build.
#             Useful if you want to continue where you left off
#             if the script aborts on a previous attempt.
#
# Search for required commands
cmds="crew git"
for c in $cmds; do
  command -v $c > /dev/null && continue || { echo "$c command not found."; exit 1; }
done

# Determine if a packages directory exists from the cloned repository
packages_dir=$(echo $(git rev-parse --git-dir 2> /dev/null) | sed -e 's,.git,packages,')
if [ ! -d "$packages_dir" ]; then
  echo "Not a valid Chromebrew repository."
  exit 1
fi

# Generate working directory
if test $1; then
  workdir=$1
  if [ ! -d "$workdir" ]; then
    mkdir -p $workdir
  fi
else
  workdir=$(date +%Y%m%d%H%M)
  mkdir $workdir
fi

# Get architecture
arch=$(uname -m)

# Exclude fake packages
exclusions="buildessential glibc parallel wayland xorg_proto"

# Exclude packages without architecture support
if [[ "$arch" == "aarch64" || "$arch" == "armv7l" ]]; then
  exclusions="$exclusions cbase dropbox freebasic google_cloud_sdk lldb mesa misctools"
fi

# Packages that need binary builds
packages=$(grep -L "$arch:" $packages_dir/*.rb | sed -e "s,$packages_dir/,,g" | cut -d'.' -f1 | xargs)

# Determine the starting package, if necessary
start=
if test $2; then
  for p in $packages; do
    if [[ "$2" == "$p" ]]; then
      start=$2
      break
    fi
  done
fi

# Continue unless there is a starting package
continue=1
if test $start; then
  continue=
fi

# Change to the working directory
cd $workdir

# Loop through packages that need a binary build
for p in $packages; do
  package=$(ls $p-*.xz 2> /dev/null)
  # Operate only on packages that don't already have a build
  if [ ! -f "$package" ]; then
    if [[ "$start" == "$p" ]]; then
      continue=1
    fi
    # Determine if the package should be excluded
    exclude=
    for e in $exclusions; do
      if [[ "$e" == "$p" ]]; then
        exclude=1
        break
      fi
    done
    # Build only if necessary
    if test $continue; then
      if ! test $exclude; then
        crew build $p
      fi
    fi
  fi
done
