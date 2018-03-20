require 'package'

class Isl < Package
  description 'Integer Set Library for manipulating sets and relations of integer points bounded by linear constraints'
  homepage 'http://isl.gforge.inria.fr/'
  version '0.19'
  source_url 'http://repo.or.cz/isl.git/snapshot/0ce949a1277de2e3121ed5715bdde639d6f4ba0f.tar.gz'
  source_sha256 '4d221ca3f4d6ddd262d03aeb7322c8662e1445538a6dbf3a1cc7847acdf59a6f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/isl-0.19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '283848ab4ed9cc4df03232f957f6aa9f971622d25740d7c007276bb58127eec1',
     armv7l: '283848ab4ed9cc4df03232f957f6aa9f971622d25740d7c007276bb58127eec1',
       i686: '486c9760a9f9bd9da749ce68b9715e310df6346ccba8cd8b999939e0d2a75c91',
     x86_64: 'e726e35c44fc64c1e0593afd7930606229ed4d8b5942fd9a85016df3fa5b701f',
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "ln -s #{CREW_LIB_PREFIX}/libisl.so.19 #{CREW_DEST_LIB_PREFIX}/libisl.so.15"
  end

  def self.check
    system 'make', 'check'
  end
end
