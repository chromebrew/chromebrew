require 'package'

class Libticables2 < Package
  description 'Libticables2 offers the library used to connect to and perform read/write operations on TI Calculators via. USB.'
  homepage 'http://lpg.ticalc.org/prj_tilp/'
  version '1.3.5'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/tilp/files/tilp2-linux/tilp2-1.18/libticables2-1.3.5.tar.bz2'
  source_sha256 '0c6fb6516e72ccab081ddb3aecceff694ed93aec689ddd2edba9c7c7406c4522'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libticables2-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libticables2-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libticables2-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libticables2-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e5fd5d8af7ad9b76dfc63ecdcc5ba071c2f8979da696b7f8fd9f9859b426931',
     armv7l: '0e5fd5d8af7ad9b76dfc63ecdcc5ba071c2f8979da696b7f8fd9f9859b426931',
       i686: '605a90ca0eeba45b49f89abc1f85c31496aa578903c532712ab5d42622e4dc41',
     x86_64: 'b7636dbe6f8b61a5e1e14199e635fdcf65c295366c48049bc0a2f3bf61083e08',
  })

  depends_on 'libusb'
  depends_on 'libtifiles2'

  def self.build
    system 'autoreconf -i'
    system "/usr/bin/env",
      "CC=clc -fuse-ld=lld",
      "CXX=clc++ -fuse-ld=lld",
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
