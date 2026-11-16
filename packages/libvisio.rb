# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version "0.1.12-#{CREW_ICU_VER}"
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.libreoffice.org/libvisio'
  git_hashtag "libvisio-#{version.split('-')[0]}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f088b3a20d10e7642c2faa4aaf5810ae64a7622b595aad1b5ff566b429246167',
     armv7l: 'f088b3a20d10e7642c2faa4aaf5810ae64a7622b595aad1b5ff566b429246167',
     x86_64: '4ce036d144c82b62947336b1c264ee553f8200b5e947eb0151fca011bdbd8914'
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
