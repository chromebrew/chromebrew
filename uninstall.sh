#!/bin/bash
packages="$(crew search | grep '(i)' | cut -d':' -f1 | cut -d')' -f2 | sed 's,\[0m,,g' | tr -dc '[:print:]' | sed 's, ruby , ,')"
for package in $packages; do
  crew remove $package
  rm -rf /usr/local/db/$package
  rm -rf /usr/local/etc/$package
  rm -rf /usr/local/lib/$package
  rm -rf /usr/local/lib64/$package
  rm -rf /usr/local/libexec/$package
  rm -rf /usr/local/opt/$package
  rm -rf /usr/local/share/$package
  rm -rf /usr/local/$package
done
crew remove ruby
rm -rf /usr/local/lib/node_modules
rm -rf /usr/local/lib/ruby
rm -rf /usr/local/lib/crew
rm -f /usr/local/bin/crew
