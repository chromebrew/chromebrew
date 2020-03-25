require 'package'

class Libva < Package
  description 'Libva is an implementation for VA-API (VIdeo Acceleration API)'
  homepage 'https://01.org/linuxmedia'
  version '2.6.1'
  source_url 'https://github.com/intel/libva/releases/download/2.6.1/libva-2.6.1.tar.bz2'
  source_sha256 '6c57eb642d828af2411aa38f55dc10111e8c98976dbab8fd62e48629401eaea5'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libdrm'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
