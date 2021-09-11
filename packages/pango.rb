require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  version '1.49.1'
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1_armv7l/pango-1.49.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1_armv7l/pango-1.49.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1_i686/pango-1.49.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.49.1_x86_64/pango-1.49.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '34371224fc5fa1134e9ede5b2c8851edcd21234117fa82debdede86ad60ee8a7',
     armv7l: '34371224fc5fa1134e9ede5b2c8851edcd21234117fa82debdede86ad60ee8a7',
       i686: '38283172c022958a30c410963f4ee3808f418e6a819f4067ab698b03065cc639',
     x86_64: '164ad6211444cfd9938a761617d1fc65770574026af6c3024111ae53ca8fde85'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi' # Gets built inside install automatically.
  depends_on 'glib'
  depends_on 'gobject_introspection' # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz'
  depends_on 'libx11'
  depends_on 'libxft'
  depends_on 'libxrender'
  depends_on 'py3_six'

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
