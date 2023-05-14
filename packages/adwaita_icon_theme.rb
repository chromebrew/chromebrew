require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '44.0'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/44.0_armv7l/adwaita_icon_theme-44.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/44.0_armv7l/adwaita_icon_theme-44.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/44.0_x86_64/adwaita_icon_theme-44.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '19f35860d9a53af813be04af39664a13ba99301cd3e40725d91ad89f18ad65a1',
     armv7l: '19f35860d9a53af813be04af39664a13ba99301cd3e40725d91ad89f18ad65a1',
     x86_64: '8811909edf89ec6e1a461c7289831d043458c1d0ed9b8a31a7a805628484c61b'
  })

  depends_on 'cantarell_fonts' # L
  depends_on 'gtk3' => :build
  depends_on 'librsvg' => :build
  depends_on 'gdk_pixbuf' => :build
  depends_on 'vala' => :build
  depends_on 'xdg_base'

  gnome

  def self.build
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "env GDK_PIXBUF_MODULEDIR='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' \
    GDK_PIXBUF_MODULE_FILE='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' \
    gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    # Update mime database.
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
