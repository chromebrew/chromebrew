#!/bin/bash
packages="$(crew search | grep '(i)' | cut -d':' -f1 | cut -d')' -f2 | sed 's,\[0m,,g' | tr -dc '[:print:]' | sed 's, ruby , ,')"
for package in $packages; do
  crew remove $package
  /bin/rm -rf /usr/local/db/$package
  /bin/rm -rf /usr/local/etc/$package
  /bin/rm -rf /usr/local/lib/$package
  /bin/rm -rf /usr/local/lib64/$package
  /bin/rm -rf /usr/local/libexec/$package
  /bin/rm -rf /usr/local/opt/$package
  /bin/rm -rf /usr/local/share/$package
  /bin/rm -rf /usr/local/$package
done
crew remove ruby
/bin/rm -rf /usr/local/lib/node_modules
/bin/rm -rf /usr/local/lib/perl*
/bin/rm -rf /usr/local/include/python*
/bin/rm -rf /usr/local/lib/python*
/bin/rm -rf /usr/local/lib64/python*
/bin/rm -rf /usr/local/include/ruby*
/bin/rm -rf /usr/local/lib/ruby*
/bin/rm -rf /usr/local/lib64/ruby*
/bin/rm -rf /usr/local/lib/crew
/bin/rm -f /usr/local/bin/crew
