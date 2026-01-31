#!/bin/bash
# This is for use in Chromebrew Github CI Unit Tests.
# Version 1.4
set -e
echo "Chromebrew GitHub Action Unit Test Stub"
last_update=$(stat -c %y /usr/local/lib/crew/tests/unit_test_stub.sh)
echo "Last Updated: ${last_update}"
stub_mtime=$(stat -c %Y /usr/local/lib/crew/tests/unit_test_stub.sh)
echo "CHANGED_PACKAGES: ${CHANGED_PACKAGES}"
echo "NON_PKG_CHANGED_FILES: ${NON_PKG_CHANGED_FILES}"
cd /usr/local/lib/crew/packages/
yes | crew update
yes | crew upgrade
# Run twice.
yes | crew upgrade
# Install required gems.
require_gem () {
  set +e
  for g in "$@"
  do
    install_gem=0
    # Check to see if the gem is recorded as installed AND if there are
    # gem contents before assuming that the gem is installed.
    if gem list --no-update-sources -l -e "$g" 2>/dev/null | grep -q "$g"; then
      :
    else
      install_gem=1
    fi
    # shellcheck disable=SC2143
    if [[ $(gem contents "$g" 2>/dev/null | grep 'Unable to find gem') ]] || [[ "$(gem contents "$g" 2>/dev/null | wc -l)" == "0" ]]; then
      install_gem=1
    else
      :
    fi
   [[ $install_gem == '1' ]] && gem install -N "$g"
  done
  set -e
}
require_gem regexp_parser dagwood ruby-libversion highline ptools cgi rubocop rubocop-chromebrew
new_stub_mtime=$(stat -c %Y /usr/local/lib/crew/tests/unit_test_stub.sh)
if [[ "$new_stub_mtime" != "$stub_mtime" ]]; then
  echo "unit_test_stub.sh has been updated. Reloading..."
  exec $0
fi
/usr/local/lib/crew/tests/unit_test.sh
