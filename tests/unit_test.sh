#!/bin/bash -e
# This is for use as a Github CI Pull Request Unit Test.
echo "ALL_CHANGED FILES is/are ${ALL_CHANGED_FILES}."
echo "CHANGED_PACKAGES is/are ${CHANGED_PACKAGES}."
cd /usr/local/lib/crew/packages/
yes | crew upgrade
yes | crew install vim
yes | crew remove vim
ruby ../tests/commands/const.rb
ruby ../tests/commands/help.rb
ruby ../tests/commands/list.rb
ruby ../tests/commands/prop.rb
ruby ../tests/commands/remove.rb
ruby ../tests/lib/docopt.rb
if [[ -n ${ALL_CHANGED_FILES-} ]]; then
  # for file in ${ALL_CHANGED_FILES}; do
    # ruby ../tests/prop_test "$file"
    # ruby ../tests/buildsystem_test "$file"
  # done
  if [[ -n ${CHANGED_PACKAGES-} ]]; then
    all_compatible_packages=$(crew list -d compatible)
    for pkg in ${CHANGED_PACKAGES}
      do
      # Only check packages compatible with the architecture
      # being run on.
      if echo "${all_compatible_packages}" | grep "^${pkg}$"; then
        ruby ../tests/prop_test "${pkg}"
        ruby ../tests/buildsystem_test "${pkg}"
        echo "Testing install/removal of compatible package ${pkg}."
        yes | time crew install "${pkg}"
        # Removal of essential packages is expected to fail.
        if [[ $(crew list -d essential) == *"${pkg}"* ]]; then
         yes | time crew remove "${pkg}" || true
        else
         yes | time crew remove "${pkg}"
        fi
      fi
    done
  fi
fi
cd ~
git clone --depth=1 https://github.com/chromebrew/chromebrew.git build_test
cd build_test
yes | CREW_CACHE_ENABLED=1 crew build -vf packages/hello_world_chromebrew.rb
