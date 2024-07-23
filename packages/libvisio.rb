# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version '0.1.7-2'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libvisio/libvisio-0.1.7.tar.xz'
  source_sha256 '8faf8df870cb27b09a787a1959d6c646faa44d0d8ab151883df408b7166bea4c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '881a0996ae47fc7f1402972814298d56a8f1d5e5d94b8c65f3d02a0a120d23d3',
     armv7l: '881a0996ae47fc7f1402972814298d56a8f1d5e5d94b8c65f3d02a0a120d23d3',
       i686: '51dc3a8c3c3e003423abcf95e2fe1306ef47e75e2311ed96aa747833e02c1ea3',
     x86_64: '576f1a0274289b8ec2c4204af563e71e238824c2d03a2ff521077c90be6f7cb8'
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
  depends_on 'zlibpkg' # R
end
