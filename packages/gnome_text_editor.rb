require 'package'

class Gnome_text_editor < Package
  description 'GNOME Text Editor (2021)'
  version '41.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/gnome-text-editor.git'
  git_hashtag version

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/3.39.92-ft42_i686/gnome_text_editor-3.39.92-ft42-chromeos-i686.tar.xz',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/41.0_armv7l/gnome_text_editor-41.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/41.0_armv7l/gnome_text_editor-41.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gnome_text_editor/41.0_x86_64/gnome_text_editor-41.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '0d33f1154b5585761521d53a134b308f8b0791173f1790599f32834b8767c82a',
    aarch64: '3c6c53b201f156f8be39c6bbfdd6ba5c3a6d35dc3a5402b8da7ea106e533e838',
     armv7l: '3c6c53b201f156f8be39c6bbfdd6ba5c3a6d35dc3a5402b8da7ea106e533e838',
     x86_64: '2b1b22e41c7725a7055e150a78062ebba90d515ee39599195e27c006dcac88e9'
  })

  depends_on 'glib'
  depends_on 'gspell'
  depends_on 'gtk3'
  depends_on 'gtk4'
  depends_on 'ibus'
  depends_on 'gtksourceview_5'
  depends_on 'libadwaita'
  depends_on 'libpeas'
  depends_on 'pango'
  depends_on 'pcre'
  depends_on 'pygobject'
  depends_on 'yelp_tools' => :build
  depends_on 'vala' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
            builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas/"
  end
end
