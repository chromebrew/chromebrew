require 'package'

class Libconfig < Package
  description 'C/C++ Configuration File Library.'
  homepage 'https://hyperrealm.github.io/libconfig/'
  version '1.7.2'
  compatibility 'all'
  source_url 'https://hyperrealm.github.io/libconfig/dist/libconfig-1.7.2.tar.gz'
  source_sha256 '7c3c7a9c73ff3302084386e96f903eb62ce06953bb1666235fac74363a16fad9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libconfig-1.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libconfig-1.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libconfig-1.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libconfig-1.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7b9b54f7ba2ce3e68fc5db6d60645a38f981761ca2ba2b5e6459d924f368bb97',
     armv7l: '7b9b54f7ba2ce3e68fc5db6d60645a38f981761ca2ba2b5e6459d924f368bb97',
       i686: 'b24fb6a0b594f006b3bcc14e4d2866d83e22769184ed592f48bc8945ce4e19ff',
     x86_64: '1abaaa24f429d5f640413707a606d10916fccab2644b723a1ee3b36ea17ec590',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
