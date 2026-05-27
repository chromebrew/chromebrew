# Adapted from Arch Linux libcdr PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libcdr/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libcdr < Autotools
  description 'CorelDraw file format importer library for LibreOffice'
  homepage 'https://wiki.documentfoundation.org/DLP/Libraries/libcdr'
  version "0.1.9-#{CREW_ICU_VER}"
  license 'GPL2 LGPL2.1 MPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://dev-www.libreoffice.org/src/libcdr/libcdr-#{version.split('-')[0]}.tar.xz"
  source_sha256 'f7bb6abdd7f226820f288a93dd8d07759833c0250d9e202af90f9b312c4665a3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a3bbb00baf8dd6067992fe59673b3375e63e68ca7bab334787a3af6e3cae2ec',
     armv7l: '5a3bbb00baf8dd6067992fe59673b3375e63e68ca7bab334787a3af6e3cae2ec',
     x86_64: '181ba9ea38edbbf49ba3136124f1aab83b3a7f669b45a037dde305ef1d08f17e'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'lcms' => :library
  depends_on 'librevenge' => :library
  depends_on 'libwpg' => :build
  depends_on 'zlib' => :library
end
