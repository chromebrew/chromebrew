#!/bin/bash
if ![[ -n ${GITLAB_TOKEN_USERNAME-} ]]; then
  echo "GITLAB_TOKEN_USERNAME not set."
  exit 1
fi
if ![[ -n ${GITLAB_TOKEN-} ]]; then
  echo "GITLAB_TOKEN not set."
  exit 1
fi
export CREW_AGREE_TIMEOUT_SECONDS=1
tools/build_updated_packages.rb --skip $@
