require 'package'

class Librsync < Package
  description 'remote delta-compression library'
  homepage 'https://librsync.github.io/'
  version '2.0.1'
  source_url 'https://github.com/librsync/librsync/archive/v2.0.1.tar.gz'
  source_sha256 '6fce69041aa4fc72a21f1ab280a7299b82df2b1fa0a25d8695fd527e6752625e'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build
  depends_on 'zlibpkg'

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX} -DCMAKE_C_FLAGS='-fPIC'"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
