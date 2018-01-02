require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.2.20-1'
  source_url 'https://github.com/rfc1036/whois/archive/v5.2.20.tar.gz'
  source_sha256 '1812b9c64a41d8ed70507bb1161a18a0a7b2f29ba5b442ca7828a5acb1e44c7e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.2.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.2.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.2.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/whois-5.2.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f540befde8dc78202a0c7c30e73b15bf7e3db6bf108e762e231a58bf7f2f8eb',
     armv7l: '0f540befde8dc78202a0c7c30e73b15bf7e3db6bf108e762e231a58bf7f2f8eb',
       i686: '543cd5034dce8928a35d03c90d9f1357b98321b4135c93f3b0bd1c92e51edd64',
     x86_64: 'b8125e4f3ab2652c45069d0e56ea7eb9118f7555e4b1deafb057f43ac42b691b',
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
    system "gzip -9 mkpasswd.1 whois.1 whois.conf.5"
    system "install -Dm755 mkpasswd #{CREW_DEST_PREFIX}/bin/mkpasswd"
    system "install -Dm755 whois #{CREW_DEST_PREFIX}/bin/whois"
    system "install -Dm644 whois.conf #{CREW_DEST_PREFIX}/etc/whois.conf"
    system "install -Dm644 mkpasswd.1.gz #{CREW_DEST_PREFIX}/man/man1/mkpasswd.1.gz"
    system "install -Dm644 whois.1.gz #{CREW_DEST_PREFIX}/man/man1/whois.1.gz"
    system "install -Dm644 whois.conf.5.gz #{CREW_DEST_PREFIX}/man/man5/whois.conf.5.gz"
  end
end
