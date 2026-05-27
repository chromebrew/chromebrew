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
    aarch64: 'e6af1bda9a95c61cdee8c318407a78f186d9ede9567e3fa7fd7f9ead5587355a',
     armv7l: 'e6af1bda9a95c61cdee8c318407a78f186d9ede9567e3fa7fd7f9ead5587355a',
     x86_64: 'a8dbbbbdf8e2bad59322c470ecf497c179c618c4f06b95758d53f2252f6536c0'
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
