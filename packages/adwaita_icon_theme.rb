require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '43'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/43_armv7l/adwaita_icon_theme-43-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/43_armv7l/adwaita_icon_theme-43-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/43_i686/adwaita_icon_theme-43-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/43_x86_64/adwaita_icon_theme-43-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4173326c11e0dcd6aa69623d5610fe10bb3dcfc40c689c62d0a4d85d7ede1aa7',
     armv7l: '4173326c11e0dcd6aa69623d5610fe10bb3dcfc40c689c62d0a4d85d7ede1aa7',
       i686: '25345da36faad61524618f74072558be4c6d136ba79ba18fa53844a50d37323d',
     x86_64: '31047bf3ad759302707bede40ce53a91ee970be0acbad94e39870fbef2342ab4'
  })

  depends_on 'cantarell_fonts'
  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'vala' => :build
  depends_on 'xdg_base'
  gnome
  no_patchelf

  def self.build
    # Need to make sure svg support is properly loaded otherwise build fails.
    system "env GDK_PIXBUF_MODULEDIR='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders' \
    GDK_PIXBUF_MODULE_FILE='#{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache' \
    gdk-pixbuf-query-loaders > #{CREW_LIB_PREFIX}/gdk-pixbuf-2.0/2.10.0/loaders.cache"
    # Update mime database.
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
