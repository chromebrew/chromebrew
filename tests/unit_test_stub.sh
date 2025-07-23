#!/bin/bash
# This is for use in Chromebrew Github CI Unit Tests.
# Version 1.1
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
new_stub_mtime=$(stat -c %Y /usr/local/lib/crew/tests/unit_test_stub.sh)
if [[ "$new_stub_mtime" != "$stub_mtime" ]]; then
  echo "unit_test_stub.sh has been updated. Reloading..."
  exec $0
fi
/usr/local/lib/crew/tests/unit_test.sh
