#!/bin/bash

echo creating file list
find . -type f > ../filelist && find . -type l >> ../filelist && cut -c2- ../filelist > filelist

echo creating directory list
find . -type d > ../dlist && cut -c2- ../dlist > dlistcut && tail -n +2 dlistcut > dlist

echo removing temporary files
rm dlistcut ../dlist ../filelist

echo building binary package
tar -czf ../package.tar.gz *
sha1sum ../package.tar.gz > ../package.tar.gz.sha1

echo finished
cat ../package.tar.gz.sha1
