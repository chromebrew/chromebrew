#cd to /usr/local so we are certain we are able to execute stuff (certain partitions are mounted with no execute privileges)
cd /usr/local

#create work directory and cd into it
mkdir chromebrew_install
cd chromebrew_install

#download installation files
wget https://raw.github.com/skycocker/chromebrew/master/$(uname -m)_links
wget https://raw.github.com/skycocker/chromebrew/master/lib_files_already_present_in_system_list

#download precompiled core tarballs
for url in $(cat $(uname -m)_links)
do
  wget --content-disposition $url
done

#extract tarballs
for tarball in *.tar.gz
do
  tar -xf $tarball
done

#install tarballs content
cp -r usr/* /usr

#this is sort of an ugly hack, fix if you feel like it's worth your time :p
ln -s /usr/local/lib/libmpc.so.3 /usr/local/lib/libmpc.so.2

#link already present files to avoid conflicts
for filename in $(cat lib_files_already_present_in_system_list) 
do
  ln -s /lib/$filename /usr/local/lib/$filename
done
