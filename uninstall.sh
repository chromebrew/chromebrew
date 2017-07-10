#!/bin/bash
IFS=' '
packages="$(crew search | grep '(i)' | cut -d':' -f1 | cut -d')' -f2 | sed 's,\[0m,,g' | tr -dc '[:print:]' | sed 's, ruby,,')"
for package in $packages; do
  crew remove $package
done
crew remove ruby
