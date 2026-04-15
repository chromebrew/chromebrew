# Adapted from Arch Linux librevenge PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/librevenge/trunk/PKGBUILD

require 'buildsystems/autotools'

class Librevenge < Autotools
  description 'library for REVerses ENGineered formats filters'
  homepage 'https://sf.net/p/libwpd/librevenge/'
  version '0.0.5'
  license 'MPL'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://sourceforge.net/projects/libwpd/files/librevenge/librevenge-#{version}/librevenge-#{version}.tar.xz"
  source_sha256 '106d0c44bb6408b1348b9e0465666fa83b816177665a22cd017e886c1aaeeb34'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19cf4e4133e45e26146a614103ac2833a27cfd936dbd28c3cacd5083c8933200',
     armv7l: '19cf4e4133e45e26146a614103ac2833a27cfd936dbd28c3cacd5083c8933200',
     x86_64: 'd4d98277ce9ae12577116597ef135c3a1cb623eda2d09a80e0e23ab94d4bf3e1'
  })

  depends_on 'boost' => :build
  depends_on 'cppunit' => :build
  depends_on 'doxygen' => :build
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'zlib' => :library

  autotools_configure_options '--disable-werror'

  run_tests
end
