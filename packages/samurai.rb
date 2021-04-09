require 'package'

class Samurai < Package
  description 'Samurai is a ninja compatible build tool written in C.'
  homepage 'https://github.com/michaelforney/samurai'
  version '1.2'
  license 'Apache-2.0 and MIT'
  compatibility 'all'
  source_url 'https://github.com/michaelforney/samurai/releases/download/1.2/samurai-1.2.tar.gz'
  source_sha256 '3b8cf51548dfc49b7efe035e191ff5e1963ebc4fe8f6064a5eefc5343eaf78a5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/samurai-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/samurai-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/samurai-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/samurai-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bf38ed51c2b3ade1b3879a09ae2962660a7c89c88ac6dcbf673378e58b04d33c',
     armv7l: 'bf38ed51c2b3ade1b3879a09ae2962660a7c89c88ac6dcbf673378e58b04d33c',
       i686: '2e79ba64fe6e772aea6520b026d5564baaa7420e3b3b2fd344a39fdb18988381',
     x86_64: 'a91fba00b13f46aabd60a96b652b8e4629fcd209eb18692c15f3dac1595fd9d4',
  })

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
