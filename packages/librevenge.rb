# Adapted from Arch Linux librevenge PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/librevenge/trunk/PKGBUILD

require 'package'

class Librevenge < Package
  description 'library for REVerses ENGineered formats filters'
  homepage 'https://sf.net/p/libwpd/librevenge/'
  version '0.0.5-1'
  license 'MPL'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-0.0.5/librevenge-0.0.5.tar.xz'
  source_sha256 '106d0c44bb6408b1348b9e0465666fa83b816177665a22cd017e886c1aaeeb34'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6421705364f2d4a215fc4054a0823bd1e54de3eb16655c3e1eb9d6c73a809b99',
     armv7l: '6421705364f2d4a215fc4054a0823bd1e54de3eb16655c3e1eb9d6c73a809b99',
       i686: '5d054402f5dea45a2d447d8061623b2e8cc78e2ac8930764237c1f3268b94e82',
     x86_64: 'e901118ae6c6e85b788c76f2d3d6b304ede8e2d94484823e68487bb212a77720'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-werror"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR}/ install"
  end
end
