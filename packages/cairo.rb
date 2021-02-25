require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.4'
  compatibility 'all'
  source_url 'https://cairographics.org/snapshots/cairo-1.17.4.tar.xz'
  source_sha256 '74b24c1ed436bbe87499179a3b27c43f4143b8676d8ad237a6fa787401959705'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.17.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.17.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.17.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/cairo-1.17.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9ff5df66de2bf89670852e030379a6c1873dfc2e154e86fe0992ee6ebebe4be9',
     armv7l: '9ff5df66de2bf89670852e030379a6c1873dfc2e154e86fe0992ee6ebebe4be9',
       i686: 'f0fb7bee8a0311b73b1a8b5a877b9a276d4bce929a267dd2be9542437cbc12bb',
     x86_64: 'b12d21a683f06db69052f2d927039f6e893aecdc993de1b384af9267d25ff93e'
  })

  depends_on 'libpng'
  depends_on 'lzo'
  depends_on 'pixman'
  depends_on 'mesa'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    --default-library=both \
    -Dgl-backend=auto \
    -Dglesv3=enabled \
    -Dxlib-xcb=enabled \
    -Dtee=enabled \
    -Dtests=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
