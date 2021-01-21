#!/bin/bash

# A script to check jfrog (bintray) for binaries existence and update package file
#
# Usage
#
#   chkfrog package...              Check packages
#
# Directory structure
#
#   Unfortunately, we need to have sha256 files locally to update URL correctly.
#
#   release/armv7l/*.tar.xz.sha256  SHA256 files for armv7l
#   release/i686/*.tar.xz.sha256    SHA256 files for i686
#   release/x86_64/*.tar.xz.sha256  SHA256 files for x86_64

URL="https://dl.bintray.com/chromebrew/chromebrew"

case $# in
0) set `basename -s .rb packages/*`
esac

function update_url () {
    if sed -e '/binary_url.*({/,/})/p; d' packages/$1.rb | grep -q $2:; then
#       sed -e "/binary_url.*({/,/})/s,$2:.*,$2: '$3'," -i packages/$1.rb
        sed -e "/$2:.*\(http\|https\|ftp\):/c\ \ \ \ $(printf %7s $2): '$3'," -i packages/$1.rb
    else
        sed -e "/binary_url.*({/a\ \ \ \ $(printf %7s $2): '$3'," -i packages/$1.rb
    fi
}
function update_sha256 () {
    if sed -e '/binary_sha256.*({/,/})/p; d' packages/$1.rb | grep -q $2:; then
#       sed -e "/binary_sha256.*({/,/})/s,$2:.*,$2: '$3'," -i packages/$1.rb
        sed -e "/$2:.*['\"][0-9a-f]*['\"]/c\ \ \ \ $(printf %7s $2): '$3'," -i packages/$1.rb
    else
        sed -e "/binary_sha256.*({/a\ \ \ \ $(printf %7s $2): '$3'," -i packages/$1.rb
    fi
}
function get_sha256 () {
    if [ -f release/$2/$1.sha256 ]; then
        cut -d' ' -f1 release/$2/$1.sha256
    else
        echo not found
    fi
}
function check_url () {
    curl --output /dev/null --silent --header -L --fail $1
}

for name in "$@"; do
    name=`basename -s .rb $name`
    pkg=`echo $name | sed -e 's/-.*//'`

    if ! grep -q binary_url packages/$pkg.rb; then
        sed -e '/source_sha256/ a\
\
\ \ binary_url ({\
\ \ })\
\ \ binary_sha256 ({\
\ \ })' -i packages/$pkg.rb
    fi
    version=`grep '\<version ['"'"'"]' packages/$pkg.rb | head -1 | sed -e 's/^.*version *['"'"'"]//' -e 's/['"'"'"].*$//'`
    echo $pkg $version
    for arch in x86_64 i686 armv7l; do
        tarname="$pkg-$version-chromeos-$arch.tar"
        if check_url "$URL/$tarname.xz"; then
            url="$URL/$tarname.xz"
            sha256=`get_sha256 $tarname.xz $arch`
        elif check_url "$URL/$tarname.gz"; then
            url="$URL/$tarname.gz"
            sha256=`get_sha256 $tarname.gz $arch`
        else
            url=""
        fi
        echo $url : $sha256
        case x$url in
        x)  ;;
        *)
            update_url $pkg $arch $url
            update_sha256 $pkg $arch $sha256
            case $arch in
            armv7l)
                update_url $pkg aarch64 $url
                update_sha256 $pkg aarch64 $sha256
                ;;
            esac
            ;;
        esac
    done
done
