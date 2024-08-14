#!/bin/bash -e
# This is for use as a Github CI Pull Request Unit Test.
yes | crew upgrade
yes | crew install vim
yes | crew remove vim
ruby ../tests/commands/const.rb
ruby ../tests/commands/help.rb
ruby ../tests/commands/prop.rb
[[ -v $ALL_CHANGED_FILES ]] && [[ -n $ALL_CHANGED_FILES ]] && (
  [[ -n ${CHANGED_PACKAGES-} ]] && \
    (
    all_compatible_packages=$(crew list -d compatible)
    for pkg in ${CHANGED_PACKAGES}
      do
    if echo "${all_compatible_packages}" | grep "^${pkg}$"; then
      echo "Testing install of compatible package ${pkg}"
      yes | time crew install "${pkg}"
      yes | time crew remove "${pkg}"
    fi
    done) && \
  for file in ${ALL_CHANGED_FILES}; do
    ruby ../tests/prop_test "$file"
    ruby ../tests/buildsystem_test "$file"
  done )
cd ~
git clone --depth=1 https://github.com/chromebrew/chromebrew.git build_test
cd build_test
yes | CREW_CACHE_ENABLED=1 crew build -vf packages/hello_world_chromebrew.rb
