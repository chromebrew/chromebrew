require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.2.20'
  source_url 'https://github.com/rfc1036/whois/archive/v5.2.20.tar.gz'
  source_sha256 '1812b9c64a41d8ed70507bb1161a18a0a7b2f29ba5b442ca7828a5acb1e44c7e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gettext'

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
