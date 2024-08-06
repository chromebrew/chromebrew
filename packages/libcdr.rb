# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version '0.1.7-icu75.1'
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libcdr/libcdr-0.1.7.tar.xz'
  source_sha256 '5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f75389cc0dc595d9c126946a1869c1432f38a0aa2840e012f8af84252bfa4420',
     armv7l: 'f75389cc0dc595d9c126946a1869c1432f38a0aa2840e012f8af84252bfa4420',
       i686: '18458e613b393e2b896632d285dbad3f85c41c833176ee1593aebe4b31c0aaef',
     x86_64: '27a7b288cef16935905289ba65693ef7edbcedacf66eda9cd35b67d933f562af'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'librevenge' # R
  depends_on 'libwpg' => :build
  depends_on 'zlib' # R
end
