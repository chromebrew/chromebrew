require 'package'

class Crew_url_opener < Package
  description 'Script for opening an URL in Chrome OS browser'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'
  source_sha256 'SKIP'
  
  def self.install
    @script = <<SCRIPT
#!/bin/bash

case ${1} in
https://|http://)
  exec dbus-send \
    --system \
    --type=method_call \
    --print-reply \
    --dest=org.chromium.UrlHandlerService \
    /org/chromium/UrlHandlerService \
    org.chromium.UrlHandlerServiceInterface.OpenUrl \
    "string:${1}"
;;
-h|--help)
  cat <<EOF
open-url: Open an URL in Chrome OS browser.

Usage:
  open-url <option> [URL]
  (URL must start with 'http://' or 'https://')

  -h --help      Show this message
EOF

;;
*)
  cat <<EOF
Error: only support URL start with 'http://' or 'https://'

Type 'open-url --help' for usage
EOF

  exit 1
;;
esac
SCRIPT

  end

  def self.postinstall
    puts "Type 'url-opener' for usage"
  end
end
