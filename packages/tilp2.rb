require 'package'

class Tilp2 < Package
  description 'TiLP 2 is a linking program for Texas Instruments\' graphing calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.18'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/tilp2-1.18.tar.bz2'
  source_sha256 '7b3ab363eeb52504d6ef5811c5d264f8016060bb7bd427be5a064c2ed7384e47'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tilp2-1.18-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '201dc44208b9be80c48f7c490db5278734451890fbeb2d2a5d14453edd1fbf38',
     armv7l: '201dc44208b9be80c48f7c490db5278734451890fbeb2d2a5d14453edd1fbf38',
       i686: 'ab237640a29d6b6f5270958be66a85bc149c1e33b3bdffac6cc10e33e5de39b1',
     x86_64: '6299305628afe6455a951234e91a1ee6dc501b48d0f47b1739963080be416536',
  })

  depends_on 'libticalcs2'
  depends_on 'libglade'
  depends_on 'sommelier'

  def self.patch
    system "wget https://github.com/JL2210/patches/raw/04eeee244059b41e0f0f4bf60f38fc4b6cb1e480/tilp2-1.18-autoconf.patch"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('tilp2-1.18-autoconf.patch') ) == 'dedba5bbd1ceb9cf819ea62c156377b6e4eb4b167f33e2c4c8823c2684fa352b'
    system 'patch -Np1 -i tilp2-1.18-autoconf.patch'
  end

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
           "CC=clc -fuse-ld=lld",
           "CXX=clc++ -fuse-ld=lld",
           "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--without-kde",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
