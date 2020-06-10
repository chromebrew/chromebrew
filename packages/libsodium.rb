require 'package'

class Libsodium < Package
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.18'
  compatibility 'all'
  source_url 'https://download.libsodium.org/libsodium/releases/libsodium-1.0.18.tar.gz'
  source_sha256 '6f504490b342a4f8a4c4a02fc9b866cbef8622d5df4e5452b46be121e46636c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsodium-1.0.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'fa8d8b5496d8d1ae4e98a7c8f118898efdcb2c4b92f235ea12f73b12b36ff80e',
     armv7l: 'fa8d8b5496d8d1ae4e98a7c8f118898efdcb2c4b92f235ea12f73b12b36ff80e',
       i686: '5b2161327ebf6573fc0660bea7ef75702cd593bf3c0da0cab11a007a89567fbb',
     x86_64: 'a2dfec82f2c2c4feba5b6c3b64e61977e5f69d4ea2279266443c69ebfcddc3a7',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
