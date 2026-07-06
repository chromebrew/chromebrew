# Adapted from Arch Linux librevenge PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/librevenge/trunk/PKGBUILD

require 'buildsystems/autotools'

class Librevenge < Autotools
  description 'library for REVerses ENGineered formats filters'
  homepage 'https://sf.net/p/libwpd/librevenge/'
  version '0.0.6'
  license 'MPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-#{version}/librevenge-#{version}.tar.xz"
  source_sha256 '19eacf5ce55d7fe6a990a45142589cdf7da0c7b68701797f133482cb44f189fa'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cd61ac19e305419e1d7557124926efa49566bea072421894b6f69bf585d2bbb',
     armv7l: '3cd61ac19e305419e1d7557124926efa49566bea072421894b6f69bf585d2bbb',
     x86_64: 'bc2430e21a5f47f140745b957b45a0f7816b210355acfdf0b097efcf536ee1e5'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'zlib' => :library

  autotools_configure_options '--disable-werror'

  run_tests
end
