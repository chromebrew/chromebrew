require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  version '3.4.0'
  source_url 'https://www.libarchive.org/downloads/libarchive-3.4.0.tar.gz'
  source_sha256 '8643d50ed40c759f5412a3af4e353cffbce4fdf3b5cf321cb72cacf06b2d825e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    system "./configure \
          --prefix=#{CREW_PREFIX} \
          --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
