require 'package'

class Cairo < Package
  description 'Cairo is a 2D graphics library with support for multiple output devices.'
  homepage 'https://www.cairographics.org'
  version '1.17.5-521a3a7'
  license 'LGPL-2.1 or MPL-1.1'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairo.git'
  git_hashtag '521a3a7bdb9299d511dcb1e4f243670141e53847'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-521a3a7_armv7l/cairo-1.17.5-521a3a7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-521a3a7_armv7l/cairo-1.17.5-521a3a7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-521a3a7_i686/cairo-1.17.5-521a3a7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairo/1.17.5-521a3a7_x86_64/cairo-1.17.5-521a3a7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b25dd9988c79c6aec537112453482669e16cf3d213d3570cc74c5c36699e7bcc',
     armv7l: 'b25dd9988c79c6aec537112453482669e16cf3d213d3570cc74c5c36699e7bcc',
       i686: '22ae49c94736cb58b748a7808b61a3e76c6b759fba2cf0e4af5520a57fe18a62',
     x86_64: '9d185159bee32c5600571ee922ce105558700c5c1c0c6057e19ea724fd9f3573'
  })

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
