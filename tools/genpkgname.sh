#!/bin/bash

version=`grep '\<version ['"'"'"]' /usr/local/lib/crew/packages/$1.rb | head -1 | sed -e 's/^.*version *['"'"'"]//' -e 's/['"'"'"].*$//'`
arch=`uname -m`
echo $1-$version-chromeos-$arch.tar.xz
