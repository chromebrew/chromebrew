#chromebrew directories
CREW_CONFIG_PATH=/usr/local/etc/crew

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

#copy the packages manifest
if [ ! -f $CREW_CONFIG_PATH/packages.json ]; then
  cp packages/packages.json $CREW_CONFIG_PATH/
fi
