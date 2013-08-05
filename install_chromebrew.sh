#cd to /usr/local so we are certain we are able to execute stuff (certain partitions are mounted with no execute privileges)
echo "Changing working directory to /usr/local"
cd /usr/local

#create installation directory and cd into it
echo "Creating installation directory (/usr/local/chromebrew_install)"
mkdir chromebrew_install
cd chromebrew_install

#download installation files
echo "Downloading installation files"
wget https://raw.github.com/skycocker/chromebrew/master/$(uname -m)_links
wget https://raw.github.com/skycocker/chromebrew/master/lib_files_already_present_in_system_list

#download precompiled core tarballs
echo "Downloading core tarballs (this may take a while)"
for url in $(cat $(uname -m)_links)
do
  wget --content-disposition $url
done

#extract tarballs
echo "Extracting core tarballs (this may take a while)..."
for tarball in *.tar.gz
do
  tar -xf $tarball
done

#install tarballs content
echo "Installing core files..."
cp -r usr/* /usr

#this is sort of an ugly hack, fix if you feel like it's worth your time :p
echo "Creating symlinks..."
ln -s /usr/local/lib/libmpc.so.3 /usr/local/lib/libmpc.so.2

#link already present files to avoid conflicts
for filename in $(cat lib_files_already_present_in_system_list) 
do
  ln -s /lib/$filename /usr/local/lib/$filename
done

#check if gcc installation succeeded
if [ -f /usr/local/bin/gcc ]; then
  echo "Installation complete! You can now run gcc :)"
else
  echo "An unexpected error occured :/"
fi
