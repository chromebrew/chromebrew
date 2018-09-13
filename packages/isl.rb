require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.20'
  source_url 'http://isl.gforge.inria.fr/isl-0.20.tar.xz'
  source_sha256 'a5596a9fb8a5b365cb612e4b9628735d6e67e9178fae134a816ae195017e77aa'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.20-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '15d6fa67660ebe7bf75da2c88b9a026d9acd3cd8889fd98b04149e437f49be2c',
     armv7l: '15d6fa67660ebe7bf75da2c88b9a026d9acd3cd8889fd98b04149e437f49be2c',
       i686: 'f119e995c61577af56203cb423cd093a1211f00efbe3970e0ca133e107319a68',
     x86_64: 'a5c98769badd9e0d535618ae31da8ae3c47814228a3796644f2b2c91afe687e0',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libisl.so.20 #{CREW_DEST_LIB_PREFIX}/libisl.so.15"
  end

  def self.check
    system 'make', 'check'
  end
end
