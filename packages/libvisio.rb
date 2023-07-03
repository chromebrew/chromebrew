# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version '0.1.7-1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libvisio/libvisio-0.1.7.tar.xz'
  source_sha256 '8faf8df870cb27b09a787a1959d6c646faa44d0d8ab151883df408b7166bea4c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7-1_armv7l/libvisio-0.1.7-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7-1_armv7l/libvisio-0.1.7-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7-1_i686/libvisio-0.1.7-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7-1_x86_64/libvisio-0.1.7-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'cf522b359e4a8c916843accd9ad20b11ea9f5a5d02b109cbada695c484b0695c',
     armv7l: 'cf522b359e4a8c916843accd9ad20b11ea9f5a5d02b109cbada695c484b0695c',
       i686: '6af5f6358d7782795645ebc2c2ab132cd8c34d3619acf3f4ade4a5fc19063f64',
     x86_64: '7efd8c88816c31d43bd7b8597c92058ff81d585b12c30fe22927f62ff2ec4d48'
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
