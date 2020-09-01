require 'package'

class Libpaper < Package
  description 'Library for handling paper characteristics'
  homepage 'http://packages.debian.org/unstable/source/libpaper'
  version '1.1.28'
  compatibility 'all'
  source_url 'http://ftp.debian.org/debian/pool/main/libp/libpaper/libpaper_1.1.28.tar.gz'
  source_sha256 'c8bb946ec93d3c2c72bbb1d7257e90172a22a44a07a07fb6b802a5bb2c95fddc'

  def self.build
      system "autoreconf -fi"
      system "./configure #{CREW_OPTIONS}"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end