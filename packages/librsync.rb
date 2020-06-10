require 'package'

class Librsync < Package
  description 'remote delta-compression library'
  homepage 'https://librsync.github.io/'
  version '2.0.1-1'
  compatibility 'all'
  source_url 'https://github.com/librsync/librsync/archive/v2.0.1.tar.gz'
  source_sha256 '6fce69041aa4fc72a21f1ab280a7299b82df2b1fa0a25d8695fd527e6752625e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/librsync-2.0.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/librsync-2.0.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/librsync-2.0.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/librsync-2.0.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '49885aeceb210260c6e731c7ab45c0f3eeb65c3b5202d5d32ac848c5974a8ebc',
     armv7l: '49885aeceb210260c6e731c7ab45c0f3eeb65c3b5202d5d32ac848c5974a8ebc',
       i686: '3f3ae26981e968241522f4593051290ccb4266b36b2d9367c1afb07e541db6c5',
     x86_64: '7b997d55a11e5709a33f90e6b392b388f56ea7be1f6683027e27fb349eacdbef',
  })

  depends_on 'cmake' => :build
  depends_on 'bz2'
  depends_on 'perl'
  depends_on 'popt'
  depends_on 'zlibpkg'

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX} -DCMAKE_C_FLAGS='-fPIC'"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
