#!/bin/bash
DIRNAME=${PWD##*/}

XZ_OPT=${XZ_OPT-"-7e"}
export XZ_OPT

echo creating file list
find . -type f > ../filelist && find . -type l >> ../filelist && cut -c2- ../filelist > filelist

echo creating directory list
find . -type d > ../dlist && cut -c2- ../dlist > dlistcut && tail -n +2 dlistcut > dlist

echo removing temporary files
rm dlistcut ../dlist ../filelist

echo building binary package
tar -cJf ../$DIRNAME.tar.xz *
sha1sum ../$DIRNAME.tar.xz > ../$DIRNAME.tar.xz.sha1

echo finished
cat ../$DIRNAME.tar.xz.sha1
