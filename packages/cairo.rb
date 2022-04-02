require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.5-521a3a7'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag '521a3a7bdb9299d511dcb1e4f243670141e53847'

  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'glib'
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxrender'
  depends_on 'lzo'
  depends_on 'mesa'
  depends_on 'pixman'
  conflicts_ok # because this overwrites the limited cairo from harfbuzz

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
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
