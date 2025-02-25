#!/bin/bash
# Mapping of /output should be set in the docker run options for the
# workflows that invoke this.
cd /output/ || exit 1
crew update
git config --global --add safe.directory /output
set -x
tools/update_package_binary_hashes.rb || exit 1
