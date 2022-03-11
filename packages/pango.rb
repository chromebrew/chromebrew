require 'package'

class Pango < Package
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'http://www.pango.org/'
  @_ver = '1.50.5'
  version @_ver
  license 'LGPL-2+ and FTL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.5_armv7l/pango-1.50.5-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.5_armv7l/pango-1.50.5-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.5_i686/pango-1.50.5-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.5_x86_64/pango-1.50.5-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f8b38d2b96f4da443d316f4fd45137324f51c91394c1e9c2a1849b1e04213ad2',
     armv7l: 'f8b38d2b96f4da443d316f4fd45137324f51c91394c1e9c2a1849b1e04213ad2',
       i686: '6e6c1b69695ba150cbeb20b72a57fc9de5f585a7d46432c2a1bc8c72d91af0a3',
     x86_64: 'e0ac8c3dd0b95e6db046d2c3e68536d903a8ba8671dc01e1914852912e3ea082'
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
