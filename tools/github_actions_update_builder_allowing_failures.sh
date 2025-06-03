#!/bin/bash
# Mapping of /output should be set in the docker run options for the
# run-updater step of the generate job in .github/workflows/Updater.yml
cd /output/ || exit 1
crew update && yes | crew upgrade || true
unset LD_AUDIT
yes | crew upgrade || true
source ~/.bashrc
git config --global --add safe.directory /output
export CREW_AGREE_TIMEOUT_SECONDS=1
tools/build_updated_packages.rb --skip --continue-after-failed-builds || exit 1
