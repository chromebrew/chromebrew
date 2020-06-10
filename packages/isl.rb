require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.20-1'
  compatibility 'all'
  source_url 'http://isl.gforge.inria.fr/isl-0.20.tar.xz'
  source_sha256 'a5596a9fb8a5b365cb612e4b9628735d6e67e9178fae134a816ae195017e77aa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a8a172724c6d1721c9435946834e3072a2a8b92a7288845f13a37e6378028f1',
     armv7l: '9a8a172724c6d1721c9435946834e3072a2a8b92a7288845f13a37e6378028f1',
       i686: '964be2d6db0292809b58316e644e6d800c0a5caa7c441ab6fed1e1fa225d97e1',
     x86_64: '0cfc7be2bf9ab7ea4229c5f7a2da40c2365bc824b45df3dfa337dcfcb16df40b',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libisl.so.19.1.0 #{CREW_DEST_LIB_PREFIX}/libisl.so.15"
  end

  def self.check
    system 'make', 'check'
  end
end
