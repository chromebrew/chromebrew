require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  version '2.10'
  source_url 'https://github.com/akheron/jansson/archive/v2.10.tar.gz'
  source_sha256 'b0a899f90ade82e42da0ecabc8af1fa296d69691e7c0786c4994fb79d4833ebb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/jansson-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '042ed2b6d1c62da47f6627541db4902e4c90d0f9e967a209629e14bff34609ec',
     armv7l: '042ed2b6d1c62da47f6627541db4902e4c90d0f9e967a209629e14bff34609ec',
       i686: '38a14665a7bbcee932a663cc8432abfed86b21bafcc3442e834bd38ac2f75ad9',
     x86_64: '070d63edf8dede198b33491b7b74fcbf0b0bf6fb33632de4114443cfec96d1ad',
  })

  depends_on 'cmake' => :build

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
