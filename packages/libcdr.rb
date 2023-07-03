# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version '0.1.7-1'
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libcdr/libcdr-0.1.7.tar.xz'
  source_sha256 '5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-1_armv7l/libcdr-0.1.7-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-1_armv7l/libcdr-0.1.7-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-1_i686/libcdr-0.1.7-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-1_x86_64/libcdr-0.1.7-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '40f8a042200be901d8bd07bbb5daad10663386a48b8d8763e28fa38eef8b3369',
     armv7l: '40f8a042200be901d8bd07bbb5daad10663386a48b8d8763e28fa38eef8b3369',
       i686: 'f041ecc94e1408e137d303914dd11c7fa98de12459218bc8e87e6243fea27e29',
     x86_64: '5437233f8a237e0d04c1f2ed635e9ce6220f24fff86c8dedfd481975c4a45cd9'
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
end
