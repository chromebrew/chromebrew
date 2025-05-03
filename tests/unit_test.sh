#!/bin/bash
# This is for use as a Github CI Unit Test.
# Version 1.1
set -e
cd /usr/local/lib/crew/packages/
git clone --depth=1 --branch="$CREW_BRANCH" "$CREW_REPO" ~/build_test
# Check if rubocop-chromebrew is installed and working, and if not install it.
rubocop --require rubocop-chromebrew &>/dev/null || gem install rubocop-chromebrew
# crew wont let you build if you're in the installation directory.
(cd ~/build_test && yes | CREW_CACHE_ENABLED=1 crew build -vf ~/build_test/packages/hello_world_chromebrew.rb)
yes | crew install vim
yes | crew remove vim

# This fails due to glibc changes since the older git tag we are testing
# against.
## Only test the core functionality of crew if non-package files were modified.
#if [[ -n ${NON_PKG_CHANGED_FILES-} ]]; then
  ## Check if rake is installed and working, and if not install it.
  #rake --help &>/dev/null || gem install rake
  ## This runs the default rake action, which in our case runs the tests for commands and libraries.
  #rake -C..
  ## Reset to an older version so we can test lib/fixup.rb
  #git reset --hard effb4326b18a8731bee2f4f45010646b82900034
  ## This is a side-effect of resetting to an older version while having newer packages installed-- this is not an issue encountered by users updating from an old version.
  #gem install resolv-replace
  ## epydoc gets deprecated, and dstat gets renamed to py3_dool
  #yes | crew install epydoc dstat
  #yes | crew update
  #echo "Checking that epydoc was removed successfully."
  #crew list installed | grep -vq "epydoc"
  #echo "Checking that dstat was renamed to py3_dool."
  #crew list installed | grep -q "py3_dool"
#fi

if [[ -n ${CHANGED_PACKAGES-} ]]; then
  all_compatible_packages=$(crew list -d compatible)
  all_installed_packages=$(crew list -d installed)
  for pkg in ${CHANGED_PACKAGES}
    do
    # Only check packages compatible with the architecture being run on.
    if echo "${all_compatible_packages}" | grep "^${pkg}$"; then
      ruby ../tests/prop_test "${pkg}"
      ruby ../tests/buildsystem_test "${pkg}"
      if echo "${all_installed_packages}" | grep "^${pkg}$"; then
        echo "Testing reinstall of ${pkg}."
        yes | time crew reinstall "${pkg}"
      else
        echo "Testing install of ${pkg}."
        yes | time crew install "${pkg}"
      fi
      # Removal of essential packages is expected to fail.
      if [[ $(crew list -d essential) == *"${pkg}"* ]]; then
        echo "Testing removal of essential package ${pkg}."
        yes | time crew remove "${pkg}" || true
      else
        echo "Testing removal of ${pkg}."
        yes | time crew remove "${pkg}"
      fi
    else
      echo "${pkg^} is not compatible."
    fi
  done
fi
