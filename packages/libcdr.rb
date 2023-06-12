# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'package'

class Libcdr < Package
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version '0.1.7'
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libcdr/libcdr-0.1.7.tar.xz'
  source_sha256 '5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7_armv7l/libcdr-0.1.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7_armv7l/libcdr-0.1.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7_i686/libcdr-0.1.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7_x86_64/libcdr-0.1.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9a19cf28a71ebc18454cafd9f32d177a718a2019de4ffb594534e07ad9852bb1',
     armv7l: '9a19cf28a71ebc18454cafd9f32d177a718a2019de4ffb594534e07ad9852bb1',
       i686: '59515e0bf500daa535e9132c02b56ef21a92ae94614462a397e2a2c5ecf0bf03',
     x86_64: '6ef34db988840140936b8c073c718f50e42348b6c7b17ee20b3de2b45b6a56db'
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
  depends_on 'zlibpkg' # R

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
