#chromebrew directories
CREW_PREFIX=/usr/local
CREW_LIB_PATH=$CREW_PREFIX/lib/crew/
CREW_CONFIG_PATH=$CREW_PREFIX/etc/crew/
CREW_BREW_DIR=$CREW_PREFIX/tmp/crew/
CREW_DEST_DIR=$CREW_BREW_DIR/dest
CREW_PACKAGES_PATH=$CREW_LIB_PATH/packages

user=$(whoami)
architecture=$(uname -m)

if [ $architecture != "i686" ] && [ $architecture != "x86_64" ]; then
  echo 'Your device is not supported by Chromebrew yet.'
  exit 1;
fi

#prepare directories
sudo mkdir -p $CREW_LIB_PATH && sudo chown -R $user:$user $CREW_LIB_PATH
sudo mkdir -p $CREW_CONFIG_PATH && sudo chown -R $user:$user $CREW_CONFIG_PATH
sudo mkdir -p $CREW_CONFIG_PATH/meta && sudo chown -R $user:$user $CREW_CONFIG_PATH/meta
sudo mkdir -p $CREW_BREW_DIR && sudo chown -R $user:$user $CREW_BREW_DIR
sudo mkdir -p $CREW_DEST_DIR && sudo chown -R $user:$user $CREW_DEST_DIR
sudo mkdir -p $CREW_PACKAGES_PATH && sudo chown -R $user:$user $CREW_PACKAGES_PATH

#cd into the brew directory, everything will happen there
cd $CREW_BREW_DIR

#download ruby
echo "Downloading ruby..."

case "$architecture" in
"i686")
  link='https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz?token_hash=AAGu_5wuqZe2eDOkfL5oh4esQ8HAZJIvbMG7GplnQrSa3g&dl=1'
  ;;
"x86_64")
  link='https://dl.dropboxusercontent.com/s/bwb315aluunam6b/ruby-2.0.0-p247-chromeos1-chromeos-x86_86.tar.gz?token_hash=AAGYQhHhEpgAHCKtVVonVlXIJKZOWzq3arNsirxcRJQgLA&dl=1'
  ;;
esac

wget --content-disposition $link

#extract and install ruby
echo "Extracting ruby (this may take a while)..."
tar -xf ruby-2.0.0p247-chromeos1-chromeos-$architecture.tar.gz
echo "Installing ruby (this may take a while)..."
sudo cp -r ./usr/* /usr
mv ./dlist $CREW_CONFIG_PATH/meta/ruby.directorylist
mv ./filelist $CREW_CONFIG_PATH/meta/ruby.filelist

#download, prepare and install chromebrew
wget https://raw.github.com/skycocker/chromebrew/master/crew
chmod +x crew
sudo mv crew $CREW_PREFIX/bin
#install crew library
cd $CREW_LIB_PATH
wget https://raw.github.com/skycocker/chromebrew/master/lib/package.rb
wget https://raw.github.com/skycocker/chromebrew/master/lib/package_helpers.rb
#create the device.json file
cd $CREW_CONFIG_PATH
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
cd $CREW_PACKAGES_PATH
wget https://raw.github.com/skycocker/chromebrew/master/packages/git.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/zlib.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/libssh2.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/perl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/openssl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/curl.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/expat.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/gettext.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/python.rb
wget https://raw.github.com/skycocker/chromebrew/master/packages/readline.rb

#install readline for ruby
(echo y;) | sudo crew install readline

#install git
(echo y;) | sudo crew install git

#prepare sparse checkout .rb packages directory and do it
cd $CREW_LIB_PATH
git init
git remote add -f origin https://github.com/skycocker/chromebrew.git
git config core.sparsecheckout true
echo packages >> .git/info/sparse-checkout
git fetch origin master
git reset --hard origin/master
echo "Chromebrew installed successfully and package lists updated."
