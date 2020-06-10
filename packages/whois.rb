require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.5.2'
  compatibility 'all'
  source_url 'https://github.com/rfc1036/whois/archive/v5.5.2.tar.gz'
  source_sha256 '9e007306bc0a5e0da4fe9abd52bc79aa8202af5ee6e852fb4f130cf362340b40'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.5.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.5.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.5.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.5.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e1fb23bf6dc47d2504f8452f33668599ab039b32bbe6b70c3b4cf0f9c529a424',
     armv7l: 'e1fb23bf6dc47d2504f8452f33668599ab039b32bbe6b70c3b4cf0f9c529a424',
       i686: '737063cadba182cd240e01a64b5380c781472877b7f2dfec91c33e9049dde4a2',
     x86_64: 'b788ba9c31a33dcc7b3dafcb4984117527e1dd802994f05519631f75a14d4378',
  })

  def self.patch
    system "sed -i 's,prefix = /usr,prefix = #{CREW_PREFIX},' Makefile"
    system "sed -i 's,prefix = /usr,prefix = #{CREW_PREFIX},' po/Makefile"
    system "sed -i 's,/share/,/,g' Makefile"
    system "sed -i 's,/share/,/,g' po/Makefile"
    system "sed -i 's,/share/,/,g' config.h"
  end

  def self.build
    system 'make'
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
