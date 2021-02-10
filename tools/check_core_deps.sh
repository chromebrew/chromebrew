#!/bin/bash

# Download core packages list, ( ... ) turn it into an array
CORE_PACKAGES=( $(curl -Lsf https://github.com/skycocker/chromebrew/raw/master/tools/core_packages.txt) )

# Expand into a space-separated list.
# It's a good thing package names can't have funny characters in them :-)
CORE_PKG_PAT="${CORE_PACKAGES[*]}"

# Replace space with <backslash><pipe>
CORE_PKG_PAT="${CORE_PKG_PAT// /\\|}"

# Wrap in <backslash><L-paren>, <backslash><R-paren>. Voila, a regex!
CORE_PKG_PAT="\\(${CORE_PKG_PAT}\\)"

while [ $# -gt 0 ]
do
    pkg="${1%.rb}"
    shift
    printf "Cleaning %s.rb\n" "$pkg"
    sed -i "/^[[:blank:]]*depends_on '${CORE_PKG_PAT}'/d" /usr/local/lib/crew/packages/"${pkg}".rb
done
