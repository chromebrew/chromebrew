#chromebrew directories
CBREW_PREFIX=/usr/local
CBREW_LIB_PATH=$CBREW_PREFIX/lib/cbrew/
CBREW_CONFIG_PATH=$CBREW_PREFIX/etc/cbrew/
CBREW_BREW_DIR=$CBREW_PREFIX/tmp/cbrew/
CBREW_PACKAGES_PATH=$CBREW_LIB_PATH/packages

#prepare directories
mkdir -p $CBREW_LIB_PATH
mkdir -p $CBREW_CONFIG_PATH
mkdir -p $CBREW_CONFIG_PATH/meta
mkdir -p $CBREW_BREW_DIR
mkdir -p $CBREW_PACKAGES_PATH

#cd into the brew directory, everything will happen there
cd $CBREW_BREW_DIR

#download ruby
echo "Downloading ruby..."
architecture=$(uname -m)

case "$architecture" in
"i686")
  link='https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz?token_hash=AAGu_5wuqZe2eDOkfL5oh4esQ8HAZJIvbMG7GplnQrSa3g&dl=1'
  echo $link
  ;;
esac

wget --content-disposition $link

#extract and install ruby
echo "Extracting ruby (this may take a while)..."
tar -xf ruby-2.0.0p247-chromeos-$architecture.tar.gz
echo "Installing ruby (this may take a while)..."
cp -r ./usr/* /usr
mv ./dlist $CBREW_CONFIG_PATH/meta/ruby.directorylist
mv ./filelist $CBREW_CONFIG_PATH/meta/ruby.filelist

#download, prepare and install chromebrew
wget https://raw.github.com/skycocker/chromebrew/master/cbrew
chmod +x cbrew
mv cbrew $CBREW_PREFIX/bin
#install cbrew library
cd $CBREW_LIB_PATH
wget https://raw.github.com/skycocker/chromebrew/master/lib/package.rb
wget https://github.com/skycocker/chromebrew/blob/master/lib/package_helpers.rb
#create the device.json file
cd $CBREW_CONFIG_PATH
touch device.json
echo "{" > device.json
echo '  "architecture": "'$architecture'",' >> device.json
echo '  "installed_packages": [' >> device.json
echo '    {' >> device.json
echo '      "name": "ruby",' >> device.json
echo '      "version": "2.0.0p247"' >> device.json
echo '    }' >> device.json
echo '  ]' >> device.json
echo "}" >> device.json

#download git and its dependencies .rb package files
cd $CBREW_PACKAGES_PATH
wget https://raw.github.com/skycocker/chromebrew/master/packages/git.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/zlib.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/libssh2.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/perl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/openssl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/curl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/expat.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/gettext.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/python.rb

#install git
cbrew install git

#prepare sparse checkout .rb packages directory and do it
cd $CBREW_LIB_PATH
git init
git remote add -f origin git@github.com:skycocker/chromebrew.git
git config.sparsecheckout true
echo packages >> .git/info/sparse-checkout
git pull origin master

echo "Chromebrew installed successfully and package lists updated."
