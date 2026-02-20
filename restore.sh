#!/bin/bash
SUDO=/usr/bin/sudo
CREW_PREFIX=/usr/local
CREW_USER=$(/usr/bin/whoami)
echo
echo "The purpose of this script is to prepare to restore Chromebrew to a working state without needing to powerwash the device."
echo "Chromebrew is intended to run in a bash shell environment initiated from crosh.  A highly likely contributor to issues"
echo "with a corrupted Chromebrew is due to permissions.  All files and directories located in ${CREW_PREFIX} need to be owned"
echo "by ${CREW_USER} to ensure a properly working Chromebrew environment.  After running this script, you will need to return to"
echo "crosh and initiate bash to attempt a fresh installation of Chromebrew."
echo
if [ "${TERM}" != "xterm" ]; then
  echo "Unable to restore from bash shell.  Enter the VT-2 Developer Console and try again."
  echo "Press Ctrl + Alt + -> (right arrow) to enter the VT-2 Developer Console."
  exit 1
fi
read -n 1 -p "WARNING: This will remove ALL files and subdirectories in ${CREW_PREFIX}!  Continue? [y/N]: " response
case "${response}" in
  y|Y)
    echo
    echo "Removing all files and subdirectories in ${CREW_PREFIX}..."
    ${SUDO} /bin/rm -rf "${CREW_PREFIX}" 2> /dev/null
    ${SUDO} /bin/mkdir "${CREW_PREFIX}" 2> /dev/null
    ${SUDO} /bin/chown ${CREW_USER}:${CREW_USER} "${CREW_PREFIX}"
    ${SUDO} /bin/chmod 755 "${CREW_PREFIX}"
    echo "Restore complete.  Press Ctrl + Alt + <- (left arrow) to exit the VT-2 Developer Console and attempt a fresh installation."
    ;;
  *)
    echo
    echo "Restore canceled."
    exit 1
    ;;
esac
