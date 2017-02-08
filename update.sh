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
cp -f packages/packages.json /usr/local/etc/crew/

#copy the package.rb template
cp -f lib/package.rb /usr/local/lib/crew/
cp -f lib/package.rb /usr/local/lib/crew/lib/
