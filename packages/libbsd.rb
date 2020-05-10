require 'package'

class Libbsd < Package
  description 'This library provides useful functions commonly found on BSD systems, and lacking on others like GNU systems, thus making it easier to port projects with strong BSD origins, without needing to embed the same code over and over again on each project.'
  homepage 'https://libbsd.freedesktop.org/wiki'
  version '0.10.0'
  compatibility 'all'
  source_url 'https://libbsd.freedesktop.org/releases/libbsd-0.10.0.tar.xz'
  source_sha256 '34b8adc726883d0e85b3118fa13605e179a62b31ba51f676136ecb2d0bc1a887'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.10.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.10.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.10.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libbsd-0.10.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37a763df2252323db210cdb3ea216adaa5e04702975de7b3e13164d7b89f7b85',
     armv7l: '37a763df2252323db210cdb3ea216adaa5e04702975de7b3e13164d7b89f7b85',
       i686: '0cc3fad8e96ddf9cd0c501a48043f76c8e2d25a8ce2114912cefe0f39633a14c',
     x86_64: '1eaed035917e2d3656a3e708777cc18f3f350ec495185bae77c3a8f7e254da52',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
