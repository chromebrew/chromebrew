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
    aarch64: 'e7105c9f8bd750041d506f0e88f6f7c31bf03a64f24552d107f58d5d557fa289',
     armv7l: 'e7105c9f8bd750041d506f0e88f6f7c31bf03a64f24552d107f58d5d557fa289',
     x86_64: '183a27721b9b1a6a7a28d8c0bd365e76e92221f4a8ba31787f45394163a517f4'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'gperf' => :build
  depends_on 'icu4c' => :library
  depends_on 'lcms' # R
  depends_on 'librevenge' => :library
  depends_on 'libwpd' => :build
  depends_on 'libwpg' => :build
  depends_on 'libxml2' => :library
  depends_on 'zlib' => :executable
end
