# Adapted from Arch Linux libwpg PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/libwpg/trunk/PKGBUILD

require 'buildsystems/autotools'

class Libwpg < Autotools
  description 'Library for importing and converting Corel WordPerfecttm Graphics images.'
  homepage 'https://libwpg.sourceforge.net/'
  version '0.3.4'
  license 'LGPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://downloads.sourceforge.net/libwpg/libwpg-#{version}.tar.xz"
  source_sha256 'b55fda9440d1e070630eb2487d8b8697cf412c214a27caee9df69cec7c004de3'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1553b1f3f4ce4f49bb0b6be720ba7673e69801a2053d9bd0504cdef6051d2217',
     armv7l: '1553b1f3f4ce4f49bb0b6be720ba7673e69801a2053d9bd0504cdef6051d2217',
     x86_64: 'b89675f729f3cd3221445b9cc5a089045ffa71e60f1cf8090ceb888bb47ee0ae'
  })

  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'librevenge' => :library
  depends_on 'libwpd' => :library
  depends_on 'perl' => :build
  depends_on 'zlib' => :executable

  run_tests
end
