# Adapted from Arch Linux libvisio PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libvisio/trunk/PKGBUILD

require 'package'

class Libvisio < Package
  description 'Library providing ability to interpret and import visio diagrams'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libvisio'
  version '0.1.7'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libvisio/libvisio-0.1.7.tar.xz'
  source_sha256 '8faf8df870cb27b09a787a1959d6c646faa44d0d8ab151883df408b7166bea4c'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7_armv7l/libvisio-0.1.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7_armv7l/libvisio-0.1.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7_i686/libvisio-0.1.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libvisio/0.1.7_x86_64/libvisio-0.1.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a4e6112399cff50add9d00883d8c6b2a49ded05b48c310a96c249717b33ceca9',
     armv7l: 'a4e6112399cff50add9d00883d8c6b2a49ded05b48c310a96c249717b33ceca9',
       i686: 'bcc39f2b1b311d1064f39c0faf0d0025d6733afc99aeb02efe16c3302430959f',
     x86_64: '9c2392e62054330b7768401880a52635875714ba84dcd7add9af5fe8e14c5505'
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

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
