require 'package'

class Libticables2 < Package
  description 'Libticables2 offers the library used to connect to and perform read/write operations on TI Calculators via. USB.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.3.5'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticables2-1.3.5.tar.bz2'
  source_sha256 '0c6fb6516e72ccab081ddb3aecceff694ed93aec689ddd2edba9c7c7406c4522'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libusb'
  depends_on 'libtifiles2'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clang -fuse-ld=lld",
      "CXX=clang++ -fuse-ld=lld",
      "./configure",
      "--prefix=#{CREW_PREFIX}",
      "--enable-libusb10",
      "--disable-libusb",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'sed -i "s,tests,,g" Makefile'
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
