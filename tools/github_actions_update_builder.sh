#!/bin/bash
# Mapping of /output should be set in the docker run options for the
# run-updater step of the generate job in .github/workflows/Updater.yml
# Version 1.1
cd /output/ || exit 1
crew update && yes | crew upgrade || true
unset LD_AUDIT
yes | crew upgrade || true
source ~/.bashrc
git config --global --add safe.directory /output
export CREW_AGREE_TIMEOUT_SECONDS=1
# Install required gems.
ruby -e "require_relative 'lib/require_gem' ; require_gem 'regexp_parser' ; require_gem 'dagwood' ; require_gem 'rubocop' ; require_gem 'rubocop-chromebrew' ; puts 'Required gems installed.'.orange"
tools/build_updated_packages.rb --skip $1 $2 || exit 1
