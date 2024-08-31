#!/bin/bash -e
# This is for use as a Github CI Pull Request Unit Test.
set -e
echo "CHANGED_PACKAGES: ${CHANGED_PACKAGES}"
cd /usr/local/lib/crew/packages/
yes | crew update
yes | crew upgrade
git clone --depth=1 --branch="$CREW_BRANCH" "$CREW_REPO" ~/build_test
# crew wont let you build if you're in the installation directory.
cd ~/build_test
yes | CREW_CACHE_ENABLED=1 crew build -vf ~/build_test/packages/hello_world_chromebrew.rb
cd /usr/local/lib/crew/tests
yes | crew install vim
yes | crew remove vim
ruby ./commands/const.rb
ruby ./commands/help.rb
ruby ./commands/list.rb
ruby ./commands/prop.rb
ruby ./commands/remove.rb
ruby ./lib/docopt.rb
if [[ -n ${CHANGED_PACKAGES-} ]]; then
  all_compatible_packages=$(crew list -d compatible)
  all_installed_packages=$(crew list -d installed)
  for pkg in ${CHANGED_PACKAGES}
    do
    # Only check packages compatible with the architecture being run on.
    if echo "${all_compatible_packages}" | grep "^${pkg}$"; then
      ruby ./prop_test "${pkg}"
      ruby ./buildsystem_test "${pkg}"
      if echo "${all_installed_packages}" | grep "^${pkg}$"; then
        echo "Testing reinstall of ${pkg}."
        yes | time crew reinstall "${pkg}"
      else
        echo "Testing install of ${pkg}."
        yes | time crew install "${pkg}"
      fi
    else
      echo "${pkg^} is not compatible."
    fi
  done
fi
