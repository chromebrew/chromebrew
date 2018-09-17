require 'package'

class Tilp2 < Package
  description 'TiLP 2 is a linking program for Texas Instruments\' graphing calculators.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.18'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/tilp2-1.18.tar.bz2'
  source_sha256 '7b3ab363eeb52504d6ef5811c5d264f8016060bb7bd427be5a064c2ed7384e47'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libticalcs2'
  depends_on 'libglade'
  depends_on 'sommelier'

  def self.build
    system "wget https://github.com/JL2210/patches/raw/04eeee244059b41e0f0f4bf60f38fc4b6cb1e480/tilp2-1.18-autoconf.patch"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('tilp2-1.18-autoconf.patch') ) == 'dedba5bbd1ceb9cf819ea62c156377b6e4eb4b167f33e2c4c8823c2684fa352b'
    system 'patch -Np1 -i tilp2-1.18-autoconf.patch'
    system 'autoreconf -i'
    system "/usr/bin/env",
           "CC=clang -fuse-ld=lld",
           "CXX=clang++ -fuse-ld=lld",
           "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--without-kde",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
    system 'make install'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
