require 'package'

class Printproto < Package
  description 'Xprint build headers'
  homepage 'https://xorg.freedesktop.org'
  version '1.0.5'
  compatibility 'all'
  source_url 'https://xorg.freedesktop.org/releases/individual/proto/printproto-1.0.5.tar.bz2'
  source_sha256 '1298316cf43b987365ab7764d61b022a3d7f180b67b423eed3456862d155911a'

  def self.build
      system "./configure #{CREW_OPTIONS}"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
