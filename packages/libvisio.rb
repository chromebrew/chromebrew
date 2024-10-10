# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libvisio < Autotools
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version "0.1.7-aac02f9-#{CREW_ICU_VER}"
  license 'LGPL'
  compatibility 'all'
  source_url 'https://git.libreoffice.org/libvisio'
  git_hashtag 'aac02f9141fcaf0acc1bce2ff6a5c2e9618f9235'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '32476941af3b6807de3e4086570718b6027d6acc9037a2f2e936511600b2005d',
     armv7l: '32476941af3b6807de3e4086570718b6027d6acc9037a2f2e936511600b2005d',
       i686: '3de266981909ae345bc768e3a53e00c35b2f38c9d645d2b7190fd9de8e47895b',
     x86_64: 'a8e7e743e6499ce1625efb26bf1cd2af06fb7a3cbcf28ffb085e9439f987c6ae'
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
