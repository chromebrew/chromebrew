#chromebrew directories
OWNER="skycocker"
REPO="chromebrew"
BRANCH="master"
URL="https://raw.githubusercontent.com/$OWNER/$REPO/$BRANCH"
CREW_PREFIX=/usr/local
CREW_LIB_PATH=$CREW_PREFIX/lib/crew/
CREW_CONFIG_PATH=$CREW_PREFIX/etc/crew/
CREW_BREW_DIR=$CREW_PREFIX/tmp/crew/
CREW_DEST_DIR=$CREW_BREW_DIR/dest
CREW_PACKAGES_PATH=$CREW_LIB_PATH/packages

architecture=$(uname -m)

if [ $EUID -eq 0 ]; then
  echo 'Chromebrew should not be run as root.'
  exit 1;
fi

case "$architecture" in
"i686"|"x86_64"|"armv7l")
  ;;
*)
  echo 'Your device is not supported by Chromebrew yet.'
  exit 1;;
esac

#prepare directories
for dir in $CREW_LIB_PATH $CREW_CONFIG_PATH $CREW_CONFIG_PATH/meta $CREW_BREW_DIR $CREW_DEST_DIR $CREW_PACKAGES_PATH; do
  sudo mkdir -p $dir && sudo chown -R $USER:$USER $dir
done

#cd into the brew directory, everything will happen there
cd $CREW_BREW_DIR

#download ruby
echo "Downloading ruby..."

case "$architecture" in
"armv7l")
  link='https://dl.dropboxusercontent.com/s/w4y8b0an136fk3i/ruby-2.0.0p247-chromeos-armv7l.tar.xz'
  tarname='ruby-2.0.0p247-chromeos-'$architecture'.tar.gz'
  sha256='f3e6287ef47c78d2211e31d1d72453292c086f8b6bd08c8608abcf67f87de862'
  ;;
"i686")
  link='https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz'
  tarname='ruby-2.0.0p247-chromeos-'$architecture'.tar.gz'
  sha256='e16b0925f21c8651f780fa0be721ba04546bb70017d6da2a84fad83e4ff4ebe2'
  ;;
"x86_64")
  link='https://dl.dropboxusercontent.com/s/3dw5ue5vhf5nj8k/ruby-2.0.0-p247-chromeos1-chromeos-x86_64.tar.gz'
  tarname='ruby-2.0.0-p247-chromeos1-chromeos-'$architecture'.tar.gz'
  sha256='77bd45734f460737e14d58cc73f5b9e16d22daa05eac704115047c0d8f9b5d44'
  ;;
esac

wget -c $link -O $tarname

#verify ruby
echo "Verifying ruby..."
echo $sha256 $tarname | sha256sum -c -
if [ $? -ne 0 ]; then
  echo 'Verification failed, something may be wrong with the ruby download.'
  exit 1;
fi

#extract and install ruby
echo "Extracting ruby (this may take a while)..."
tar -xf $tarname
echo "Installing ruby (this may take a while)..."
sudo cp -r ./usr/* /usr
mv ./dlist $CREW_CONFIG_PATH/meta/ruby.directorylist
mv ./filelist $CREW_CONFIG_PATH/meta/ruby.filelist

#download, prepare and install chromebrew
cd $CREW_LIB_PATH
wget -N -c $URL/crew
chmod +x crew
sudo ln -s `pwd`/crew $CREW_PREFIX/bin
#install crew library
mkdir $CREW_LIB_PATH/lib && cd $CREW_LIB_PATH/lib
wget -N -c $URL/lib/package.rb
wget -N -c $URL/lib/package_helpers.rb
#create the device.json file
cd $CREW_CONFIG_PATH
echo '{' > device.json
echo '  "architecture": "'$architecture'",' >> device.json
echo '  "installed_packages": [' >> device.json
echo '    {' >> device.json
echo '      "name": "ruby",' >> device.json
echo '      "version": "2.0.0p247"' >> device.json
echo '    }' >> device.json
echo '  ]' >> device.json
echo '}' >> device.json

#download git package file
cd $CREW_PACKAGES_PATH
wget -N -c $URL/packages/git.rb

#install gcc on arm only.  It requires special treatments
if [ "$architecture" == "armv7l" ]; then
  cd $CREW_PACKAGES_PATH
  for file in buildessential gcc binutils make mpc mpfr gmp glibc linuxheaders; do
    wget -N -c $URL/packages/$file.rb
  done
  echo y | crew install gcc
  if [ ! -d $HOME/Downloads/tools ]; then
    mkdir $HOME/Downloads/tools
    mkdir $HOME/Downloads/tools/bin
    mkdir $HOME/Downloads/tools/lib
    mkdir $HOME/Downloads/tools/libexec
    mkdir $HOME/Downloads/tools/share
    ln -s /usr/local/armv7a-cros-linux-gnueabi $HOME/Downloads/tools
    ln -s /usr/local/bin/as $HOME/Downloads/tools/bin
    ln -s /usr/local/bin/bison $HOME/Downloads/tools/bin
    ln -s /usr/local/bin/ld $HOME/Downloads/tools/bin
    ln -s /usr/local/bin/m4 $HOME/Downloads/tools/bin
    ln -s /usr/local/lib/gcc $HOME/Downloads/tools/lib
    ln -s /usr/local/libexec/gcc $HOME/Downloads/tools/libexec
    ln -s /usr/local/share/bison $HOME/Downloads/tools/share
  fi
fi

#install git
echo y | crew install git

#Making GCC act like CC (For some npm packages out there)
sudo ln -s /usr/local/bin/gcc /usr/local/bin/cc

#This will allow a lot of things to work without sudo
sudo chown -R chronos:chronos /usr/local

#prepare sparse checkout .rb packages directory and do it
cd $CREW_LIB_PATH
git init
git remote add -f origin https://github.com/$OWNER/$REPO.git
git config core.sparsecheckout true
echo packages >> .git/info/sparse-checkout
echo lib >> .git/info/sparse-checkout
echo crew >> .git/info/sparse-checkout
git fetch origin master
git reset --hard origin/master
echo "Chromebrew installed successfully and package lists updated."
