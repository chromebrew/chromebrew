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

#This will allow a lot of things to work without sudo
sudo chown -R `id -u`:`id -g` /usr/local

#prepare directories
for dir in $CREW_LIB_PATH $CREW_CONFIG_PATH $CREW_CONFIG_PATH/meta $CREW_BREW_DIR $CREW_DEST_DIR $CREW_PACKAGES_PATH; do
  mkdir -p $dir
done

#prepare url and sha256
#  install only ruby, git and libssh2
urls=()
sha256s=()
case "$architecture" in
"armv7l")
  urls+=('https://dl.dropboxusercontent.com/s/02afb4qm4ugl0os/ruby-2.0.0p247-chromeos-armv7l.tar.xz')
  sha256s+=('de01196461edd57bb39288e7b9dee1ee3cdc605e4e8be6b8871ba47dbe1ca972')
  urls+=('https://dl.dropboxusercontent.com/s/lnz5hmjv48d14f2/git-1.8.4-chromeos-armv7l.tar.xz')
  sha256s+=('f6f7d2500a41419937944af464494dd0ab95b15877ee630a4c13dd0abb37b02d')
  urls+=('https://dl.dropboxusercontent.com/s/fq23kj42gsifcvi/libssh2-1.4.3-chromeos-armv7l.tar.xz')
  sha256s+=('c1b8b09dfae6ab82ec6c961120c38e78ee50ecf902800f8257d0916e18db0b69')
  ;;
"i686")
  urls+=('https://dl.dropboxusercontent.com/s/tufbuqcn80ubypx/ruby-2.0.0p247-chromeos-i686.tar.gz')
  sha256s+=('e16b0925f21c8651f780fa0be721ba04546bb70017d6da2a84fad83e4ff4ebe2')
  urls+=('https://dl.dropboxusercontent.com/s/g3binxopw5nfky1/git-1.8.4-chromeos-i686.tar.gz')
  sha256s+=('ef561d3b0d498b847327a90ff8c9d75daa0ae04adb83a71f22bffdbb575f6097')
  urls+=('https://dl.dropboxusercontent.com/s/zjnild1c2i10h53/libssh2-1.4.3-chromeos-i686.tar.gz')
  sha256s+=('195aef637b35166eef4c7634b133d945536fb5d3fda2c1acac99a2b74ddcc580')
  ;;
"x86_64")
  urls+=('https://dl.dropboxusercontent.com/s/3dw5ue5vhf5nj8k/ruby-2.0.0-p247-chromeos1-chromeos-x86_64.tar.gz')
  sha256s+=('77bd45734f460737e14d58cc73f5b9e16d22daa05eac704115047c0d8f9b5d44')
  urls+=('https://dl.dropboxusercontent.com/s/i7vs9wfk94tsrzt/git-1.8.4-chromeos-x86_64.tar.gz')
  sha256s+=('2938d817d1a66c94c03c886eb9cc9b2deb4f96cad6f46be82729caee46cb0197')
  urls+=('https://dl.dropboxusercontent.com/s/frzkbbnf35ie6ns/libssh2-1.4.3-chromeos-x86_64.tar.gz')
  sha256s+=('eaf7c34b7f694a0df2fc80ddea117997428e0f364f2729ef943ca81572dfcd6c')
  ;;
esac

#functions to maintain packages
function download_check () {
    cd $CREW_BREW_DIR

    #download
    echo "Downloading $1..."
    wget -c $2 -O $3

    #verify
    echo "Verifying $1..."
    echo $4 $3 | sha256sum -c -
    case $? in
    0) ;;
    *)
      echo 'Verification failed, something may be wrong with the $1 download.'
      exit 1;;
    esac
}

function extract_install () {
    cd $CREW_BREW_DIR

    #extract and install
    echo "Extracting $1 (this may take a while)..."
    rm -rf ./usr
    tar -xf $2
    echo "Installing $1 (this may take a while)..."
    tar cf - ./usr/* | (cd /; tar xp --keep-directory-symlink -f -)
    mv ./dlist $CREW_CONFIG_PATH/meta/$1.directorylist
    mv ./filelist $CREW_CONFIG_PATH/meta/$1.filelist
}

function update_device_json () {
  cd $CREW_CONFIG_PATH

  if grep '"name": "'$1'"' device.json > /dev/null; then
    echo "Updating version number of existing $1 information in device.json..."
    sed -i device.json -e '/"name": "'$1'"/N;//s/"version": ".*"/"version": "'$2'"/'
  elif grep '^    }$' device.json > /dev/null; then
    echo "Adding new $1 information to device.json..."
    sed -i device.json -e '/^    }$/s/$/,\
    {\
      "name": "'$1'",\
      "version": "'$2'"\
    }/'
  else
    echo "Adding new $1 information to device.json..."
    sed -i device.json -e '/^  "installed_packages": \[$/s/$/\
    {\
      "name": "'$1'",\
      "version": "'$2'"\
    }/'
  fi
}

#create the device.json file if it doesn't exist
cd $CREW_CONFIG_PATH
if [ ! -f device.json ]; then
  echo "Creating new device.json..."
  echo '{' > device.json
  echo '  "architecture": "'$architecture'",' >> device.json
  echo '  "installed_packages": [' >> device.json
  echo '  ]' >> device.json
  echo '}' >> device.json
fi

#extract, install and register packages
for i in `seq 0 $((${#urls[@]} - 1))`; do
  url=${urls[$i]}
  sha256=${sha256s[$i]}
  tarfile=`basename $url`
  name=${tarfile%%-*}   # extract string before first '-'
  rest=${tarfile#*-}    # extract string after first '-'
  version=`echo $rest | sed -e 's/-chromeos.*$//'`
                        # extract string between first '-' and "-chromeos"

  download_check $name $url $tarfile $sha256
  extract_install $name $tarfile
  update_device_json $name $version
done

#download, prepare and install chromebrew
cd $CREW_LIB_PATH
rm -rf crew lib packages
wget -N $URL/crew
chmod +x crew
rm -f $CREW_PREFIX/bin/crew
ln -s `pwd`/crew $CREW_PREFIX/bin
#install crew library
mkdir -p $CREW_LIB_PATH/lib
cd $CREW_LIB_PATH/lib
wget -N $URL/lib/package.rb
wget -N $URL/lib/package_helpers.rb

#Making GCC act like CC (For some npm packages out there)
rm -f /usr/local/bin/cc
ln -s /usr/local/bin/gcc /usr/local/bin/cc

#prepare sparse checkout .rb packages directory and do it
cd $CREW_LIB_PATH
rm -rf .git
git init
git remote add -f origin https://github.com/$OWNER/$REPO.git
git config core.sparsecheckout true
echo packages >> .git/info/sparse-checkout
echo lib >> .git/info/sparse-checkout
echo crew >> .git/info/sparse-checkout
git fetch origin master
git reset --hard origin/master
echo "Chromebrew installed successfully and package lists updated."
