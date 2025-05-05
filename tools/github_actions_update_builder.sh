#!/bin/bash
# Mapping of /output should be set in the docker run options for the
# run-updater step of the generate job in .github/workflows/Updater.yml
cd /output/ || exit 1
crew update && yes | crew upgrade || true
source ~/.bashrc
git config --global --add safe.directory /output
export CREW_AGREE_TIMEOUT_SECONDS=1
set -x
tools/build_updated_packages.rb --skip || exit 1
