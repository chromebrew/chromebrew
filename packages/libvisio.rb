# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version "0.1.10-#{CREW_ICU_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.libreoffice.org/libvisio'
  git_hashtag "libvisio-#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b71ebd6401037404223933521d8574bc2346479e1d93ef357e9d002b71942d19',
     armv7l: 'b71ebd6401037404223933521d8574bc2346479e1d93ef357e9d002b71942d19',
     x86_64: 'dcbcdcacbc28e9dc5fa511f9bc6b692865597c91da1cc187c535adfc5696d63e'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'icu4c' # R
  depends_on 'lcms' # R
  depends_on 'librevenge' # R
  depends_on 'libwpd' => :build
  depends_on 'libwpg' => :build
  depends_on 'libxml2' # R
  depends_on 'zlib' # R
end
