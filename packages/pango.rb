require 'buildsystems/meson'
# build order: harfbuzz => freetype => fontconfig => pango.

class Pango < Meson
  description 'Pango is a library for laying out and rendering of text, with an emphasis on internationalization.'
  homepage 'https://pango.gnome.org/'
  @_ver = '1.50.14'
  version "#{@_ver}-1"
  license 'LGPL-2+ and FTL'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pango.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_armv7l/pango-1.50.14-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_armv7l/pango-1.50.14-1-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/pango/1.50.14-1_x86_64/pango-1.50.14-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '27e2232861d2d4a563e8f32e42c3ef56d507ce792aecf6301be2b9feb98583d3',
     armv7l: '27e2232861d2d4a563e8f32e42c3ef56d507ce792aecf6301be2b9feb98583d3',
     x86_64: 'e0e5ef2a9a729f77e45d4cccdde51428ec167f705845e6c58a5b0e58209a67a6'
  })

  depends_on 'cairo' # R
  depends_on 'fontconfig' # R
  depends_on 'freetype' # R
  depends_on 'fribidi' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gobject_introspection' => :build # add this package to build gtk+, avoid compilation error
  depends_on 'harfbuzz' # R
  depends_on 'libx11' # R
  depends_on 'libxdmcp' => :build
  depends_on 'libxft' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_proto' => :build

  meson_options = "-Dinstall-tests=false \
    -Dcairo=enabled \
    -Dfreetype=enabled \
    -Dfontconfig=enabled \
    -Dlibthai=disabled \
    -Dgtk_doc=false"
end
