require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.2.16'
  source_url 'https://github.com/rfc1036/whois/archive/v5.2.16.tar.gz'
  source_sha1 '1a5afb7363ef62de0565ae10cee7f0a42b6b260e'

  def self.build
    system "sed -i 's,prefix = /usr,prefix = /usr/local,' Makefile"
    system "sed -i 's,prefix = /usr,prefix = /usr/local,' po/Makefile"
    system "sed -i 's,/share/,/,g' Makefile"
    system "sed -i 's,/share/,/,g' po/Makefile"
    system "sed -i 's,/share/,/,g' config.h"
    system "make"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man1"
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/man/man5"
    system "cp mkpasswd #{CREW_DEST_DIR}/usr/local/bin"
    system "cp whois #{CREW_DEST_DIR}/usr/local/bin"
    system "cp mkpasswd.1 #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp whois.1 #{CREW_DEST_DIR}/usr/local/man/man1"
    system "cp whois.conf.5 #{CREW_DEST_DIR}/usr/local/man/man5"
  end
end
