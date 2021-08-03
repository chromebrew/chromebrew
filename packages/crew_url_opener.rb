require 'package'

class Crew_url_opener < Package
  description 'Script for opening an URL in Chrome OS browser'
  homepage 'https://github.com/skycocker/chromebrew'
  version '1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'SKIP'

  def self.build
    @_script = <<SCRIPT
#!/bin/bash

case "${1}" in
ftp://*)
  cat <<EOF
Error: only support URL start with 'http://' or 'https://'

Type 'open-url --help' for usage
EOF

  exit 1
;;
-h|--help)
  cat <<EOF
open-url: Open an URL in Chrome OS browser.

Usage:
  open-url <option> [URL]

  -h --help      Show this message
EOF

;;
*)
  exec dbus-send \
    --system \
    --type=method_call \
    --print-reply \
    --dest=org.chromium.UrlHandlerService \
    /org/chromium/UrlHandlerService \
    org.chromium.UrlHandlerServiceInterface.OpenUrl \
    "string:http://${1/http*:\\/\\//}"
    # use http:// for compatibility
;;
esac
SCRIPT

  end

  def self.install
    @_file = "#{CREW_DEST_PREFIX}/bin/url-opener"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/"
    File.write @_file, @_script
    File.chmod 0755, @_file
  end

  def self.postinstall
    print 'Set Chrome OS browser as default? [Y/n]: '

    case STDIN.getc
    when "\n", 'Y', 'y'
      FileUtils.ln_s 'url-opener', "#{CREW_DEST_PREFIX}/bin/x-www-browser"
      puts 'Chrome OS browser is now default.'.lightgreen
    else
      puts 'No change has been made.'.orange
    end

    puts "Type 'url-opener' for usage"
  end
end
