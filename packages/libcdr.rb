# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version '0.1.7-2'
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'all'
  source_url 'https://dev-www.libreoffice.org/src/libcdr/libcdr-0.1.7.tar.xz'
  source_sha256 '5666249d613466b9aa1e987ea4109c04365866e9277d80f6cd9663e86b8ecdd4'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-2_armv7l/libcdr-0.1.7-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-2_armv7l/libcdr-0.1.7-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-2_i686/libcdr-0.1.7-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdr/0.1.7-2_x86_64/libcdr-0.1.7-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '79124696e55c0a01674829d77e7f8c9d17e688b502e94776b4a0df0e01a0f4e0',
     armv7l: '79124696e55c0a01674829d77e7f8c9d17e688b502e94776b4a0df0e01a0f4e0',
       i686: '0a7f893c78a6d7d964b7191215421333e7a98584296e50e5217262cb7ebeaf40',
     x86_64: '81bea42bae37815908e4144ad8e2da2b8a07447fed3e6cbc0e6e9d768813eafd'
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
