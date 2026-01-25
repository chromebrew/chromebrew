#!/bin/bash
# Mapping of /output should be set in the docker run options for the
# run-updater step of the generate job in .github/workflows/Updater.yml
# Version 1.0
cd /output/ || exit 1
crew update && yes | crew upgrade || true
unset LD_AUDIT
yes | crew upgrade || true
source ~/.bashrc
git config --global --add safe.directory /output
export CREW_AGREE_TIMEOUT_SECONDS=1
# Deal with a regexp_parser gem issue
gem install regexp_parser
yes | crew install ruby_rubocop ruby_dagwood
tools/build_updated_packages.rb --skip $1 $2 || exit 1
