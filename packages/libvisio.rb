# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version "0.1.11-#{CREW_ICU_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.libreoffice.org/libvisio'
  git_hashtag "libvisio-#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e1ce81e66394f1280359b1da90ee5bb7e1c1e0c0a00fa329a3bd941782daf4b',
     armv7l: '4e1ce81e66394f1280359b1da90ee5bb7e1c1e0c0a00fa329a3bd941782daf4b',
     x86_64: '1c84ab59b4b815e7ba53c08306acf3d0063b776392f7e42b1eb623f2cf0f2376'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gperf' => :build
  depends_on 'icu4c' => :library
  depends_on 'lcms' # R
  depends_on 'librevenge' => :library
  depends_on 'libwpd' => :build
  depends_on 'libwpg' => :build
  depends_on 'libxml2' => :library
  depends_on 'zlib' => :executable
end
