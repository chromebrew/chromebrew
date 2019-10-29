require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.5.2'
  source_url 'https://github.com/rfc1036/whois/archive/v5.5.2.tar.gz'
  source_sha256 '9e007306bc0a5e0da4fe9abd52bc79aa8202af5ee6e852fb4f130cf362340b40'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'gettext'

  def self.build
    system "sed -i 's,prefix = /usr,prefix = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix = /usr,prefix = #{CREW_PREFIX},' po/Makefile"
    system "sed -i 's,/share/,/,g' Makefile"
    system "sed -i 's,/share/,/,g' po/Makefile"
    system "sed -i 's,/share/,/,g' config.h"
    system "make"
  end

  def self.install
    system "gzip -9 mkpasswd.1 whois.1 whois.conf.5"
    system "install -Dm755 mkpasswd #{CREW_DEST_PREFIX}/bin/mkpasswd"
    system "install -Dm755 whois #{CREW_DEST_PREFIX}/bin/whois"
    system "install -Dm644 whois.conf #{CREW_DEST_PREFIX}/etc/whois.conf"
    system "install -Dm644 mkpasswd.1.gz #{CREW_DEST_PREFIX}/man/man1/mkpasswd.1.gz"
    system "install -Dm644 whois.1.gz #{CREW_DEST_PREFIX}/man/man1/whois.1.gz"
    system "install -Dm644 whois.conf.5.gz #{CREW_DEST_PREFIX}/man/man5/whois.conf.5.gz"
  end
end
