# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version "0.1.8-#{CREW_ICU_VER}"
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dev-www.libreoffice.org/src/libcdr/libcdr-#{version.split('-')[0]}.tar.xz"
  source_sha256 'ced677c8300b29c91d3004bb1dddf0b99761bf5544991c26c2ee8f427e87193c'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16430abafda64b90c684917dafc091e836da7265f576e7b4a151db74714d5b6b',
     armv7l: '16430abafda64b90c684917dafc091e836da7265f576e7b4a151db74714d5b6b',
     x86_64: 'b93ddcae1693bc203f022747db8e189c2e4efc2752096882a7217460b26e7ba8'
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
