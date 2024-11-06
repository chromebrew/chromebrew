#!/bin/bash
# This is for use as a Github CI Pull Request Unit Test.
set -e
stub_mtime=$(stat -c %Y /usr/local/lib/crew/tests/unit_test_stub.sh)
echo "CHANGED_PACKAGES: ${CHANGED_PACKAGES}"
cd /usr/local/lib/crew/packages/
yes | crew update
yes | crew upgrade
new_stub_mtime=$(stat -c %Y /usr/local/lib/crew/tests/unit_test_stub.sh)
if [[ "$new_stub_mtime" != "$stub_mtime" ]]; then
  echo "unit_test_stub.sh has been updated. Reloading..."
  exec $0
fi
/usr/local/lib/crew/tests/unit_test.sh
