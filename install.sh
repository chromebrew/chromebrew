#chromebrew directories
OWNER="skycocker"
REPO="chromebrew"
BRANCH="master"
URL="https://raw.githubusercontent.com/$OWNER/$REPO/$BRANCH"
CREW_PREFIX=${CREW_PREFIX:-/usr/local}
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
"i686"|"x86_64"|"armv7l"|"aarch64")
  ;;
*)
  echo 'Your device is not supported by Chromebrew yet.'
  exit 1;;
esac

#This will allow things to work without sudo
sudo chown -R `id -u`:`id -g` "${CREW_PREFIX}"

#prepare directories
for dir in $CREW_LIB_PATH $CREW_CONFIG_PATH $CREW_CONFIG_PATH/meta $CREW_BREW_DIR $CREW_DEST_DIR $CREW_PACKAGES_PATH; do
  mkdir -p $dir
done

#prepare url and sha256
#  install only ruby, git and libssh2
urls=()
sha256s=()
case "$architecture" in
"aarch64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-armv7l.tar.xz')
  sha256s+=('ad6bad7fcce9b595af3172e6ae48a2b4ffac7e0ed73daa22be4e972f4889c3a6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.16.2-chromeos-armv7l.tar.xz')
  sha256s+=('7face6622b5f2f1320d955ddb9a3349982cb0eaabb022d6190e6202292abe1f8')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz')
  sha256s+=('6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037')
  ;;
"armv7l")
  if ! type "xz" > /dev/null; then
    urls+=('https://github.com/snailium/chrome-cross/releases/download/v1.8.1/xz-5.2.3-chromeos-armv7l.tar.gz')
    sha256s+=('4dc9f086ee7613ab0145ec0ed5ac804c80c620c92f515cb62bae8d3c508cbfe7')
  fi
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-armv7l.tar.xz')
  sha256s+=('ad6bad7fcce9b595af3172e6ae48a2b4ffac7e0ed73daa22be4e972f4889c3a6')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.16.2-chromeos-armv7l.tar.xz')
  sha256s+=('7face6622b5f2f1320d955ddb9a3349982cb0eaabb022d6190e6202292abe1f8')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-armv7l.tar.xz')
  sha256s+=('6fa84296583273dd9e749a2c54cb1cf688a7dab032e2528de5944a4d9777f037')
  ;;
"i686")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-i686.tar.xz')
  sha256s+=('01bb17f706dc73013f23c15d589744858e1501c6664feef73dad1ff0e9b67599')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.16.2-chromeos-i686.tar.xz')
  sha256s+=('b82435bd7988f3e6dd989e209b77e88568da700496928839af05a6852f9fd3d0')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-i686.tar.xz')
  sha256s+=('771b2d30a49dd691db8456f773da404753d368f3c31d03c682c552ea0b5eb65e')
  ;;
"x86_64")
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/ruby-2.5.0-chromeos-x86_64.tar.xz')
  sha256s+=('1c748efef37747afb9b4f11068a2bbbaf03495bcb697310e1a39bb82a3549c71')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/git-2.16.2-chromeos-x86_64.tar.xz')
  sha256s+=('67ebddafacafe1edf717c92ffce5febf6e8910635facc8b1493e91a723c14493')
  urls+=('https://dl.bintray.com/chromebrew/chromebrew/libssh2-1.8.0-chromeos-x86_64.tar.xz')
  sha256s+=('6e026450389021c6267a9cc79b8722d15f48e2f8d812d5212501f686b4368e3c')
  ;;
esac

#functions to maintain packages
function download_check () {
    cd $CREW_BREW_DIR

    #download
    echo "Downloading $1..."
    curl -C - -# -L --ssl $2 -o "$3"

    #verify
    echo "Verifying $1..."
    echo $4 $3 | sha256sum -c -
    case $? in
    0) ;;
    *)
      echo "Verification failed, something may be wrong with the $1 download."
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
curl -# -o crew $URL/crew
chmod +x crew
rm -f $CREW_PREFIX/bin/crew
ln -s `pwd`/crew $CREW_PREFIX/bin
#install crew library
mkdir -p $CREW_LIB_PATH/lib
cd $CREW_LIB_PATH/lib
curl -# -o package.rb $URL/lib/package.rb
curl -# -o package_helpers.rb $URL/lib/package_helpers.rb

#Making GCC act like CC (For some npm packages out there)
rm -f $CREW_PREFIX/bin/cc
ln -s $CREW_PREFIX/bin/gcc $CREW_PREFIX/bin/cc

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
yes | crew install buildessential
yes | crew install less
yes | crew install most
echo
echo "To set the default PAGER environment variable to be able to use less:"
echo "echo \"export PAGER=$CREW_PREFIX/bin/less\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "Alternatively, you could use most.  Why settle for less, right?"
echo "echo \"export PAGER=$CREW_PREFIX/bin/most\" >> ~/.bashrc && . ~/.bashrc"
echo
echo "Chromebrew installed successfully and package lists updated."
