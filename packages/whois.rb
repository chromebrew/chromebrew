require 'package'

class Whois < Package
  description 'Intelligent WHOIS client'
  homepage 'https://github.com/rfc1036/whois'
  version '5.2.16'
  source_url 'https://github.com/rfc1036/whois/archive/v5.2.16.tar.gz'
  source_sha256 'd8204ca199329f14c33cb9f893b0f50918dbef34a6838317270e65c55ab32615'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/whois-5.2.16-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/whois-5.2.16-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/whois-5.2.16-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/whois-5.2.16-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6af8f5df827b4df623dcc9e6b8adc4d6c5627391cc4cc5a575db429e994c6264',
     armv7l: '6af8f5df827b4df623dcc9e6b8adc4d6c5627391cc4cc5a575db429e994c6264',
       i686: '0535b924068cb2be49b0d722969c8e7459c9d73998f32638a72db33ed9672674',
     x86_64: '778b41edd15d5c6aad04168c5be30f160fae7d5030aa7a6f90b66117ac389486',
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
