require 'package'

class Samurai < Package
  description 'Samurai is a ninja compatible build tool written in C.'
  homepage 'https://github.com/michaelforney/samurai'
  version '1.2'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/michaelforney/samurai/releases/download/1.2/samurai-1.2.tar.gz'
  source_sha256 '3b8cf51548dfc49b7efe035e191ff5e1963ebc4fe8f6064a5eefc5343eaf78a5'

  def self.patch
    system "sed -i 's:PREFIX=/usr/local:PREFIX=#{CREW_PREFIX}:' Makefile"
    system "sed -i 's:MANDIR=\$(PREFIX)/share/man:MANDIR=#{CREW_MAN_PREFIX}:g' Makefile"
  end

  def self.build
    system "make CFLAGS='-pipe -O2 -flto=auto -fuse-ld=gold' \
                LDFLAGS='-flto=auto -fuse-ld=gold' \
                CC='#{CREW_TGT}-gcc'"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
