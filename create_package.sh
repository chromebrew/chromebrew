#!/bin/bash
DIRNAME=${PWD##*/}

echo creating file list
find . -type f > ../filelist && find . -type l >> ../filelist && cut -c2- ../filelist > filelist

echo creating directory list
find . -type d > ../dlist && cut -c2- ../dlist > dlistcut && tail -n +2 dlistcut > dlist

echo removing temporary files
rm dlistcut ../dlist ../filelist
rm create_package.sh
sed '/\/create_package.sh/d' filelist

echo building binary package
tar -czf ../$DIRNAME.tar.gz *
sha1sum ../$DIRNAME.tar.gz > ../$DIRNAME.tar.gz.sha1

echo finished
cat ../$DIRNAME.tar.gz.sha1

