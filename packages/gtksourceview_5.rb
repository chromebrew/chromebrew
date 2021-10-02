require 'package'

class Gtksourceview_5 < Package
  description 'Source code editing widget'
  homepage 'https://wiki.gnome.org/Projects/GtkSourceView'
  @_ver = '5.2.0'
  version @_ver
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gtksourceview.git'
  git_hashtag @_ver

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.0.0_i686/gtksourceview_5-5.0.0-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.2.0_armv7l/gtksourceview_5-5.2.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.2.0_armv7l/gtksourceview_5-5.2.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtksourceview_5/5.2.0_x86_64/gtksourceview_5-5.2.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
       i686: 'd27b36e8275ba473c3758ae708eebd1aa80a34a346db5a44593d196f9f2f96a7',
    aarch64: '96884f9ce28885b53432644059de5acc5bc251b7f6a8d6d5c27d1a1df32c18d8',
     armv7l: '96884f9ce28885b53432644059de5acc5bc251b7f6a8d6d5c27d1a1df32c18d8',
     x86_64: '00986e7083640e3771e854efcbeb3ae5f3fbd3393743722ddd417b4604bf25af'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'graphene'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'harfbuzz'
  depends_on 'libsoup'
  depends_on 'pango'
  depends_on 'vala'
  depends_on 'vulkan_icd_loader'

  def self.patch
    system "sed -i 's/-fstack-protector-strong/-flto/g' meson.build"
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Db_asneeded=false \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
