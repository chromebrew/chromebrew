require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '42.0'
  license 'LGPL-3 and CC-BY-SA-4.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/42/42.2/sources/adwaita-icon-theme-42.0.tar.xz'
  source_sha256 '5e85b5adc8dee666900fcaf271ba717f7dcb9d0a03d96dae08f9cbd27e18b1e0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/42.0_armv7l/adwaita_icon_theme-42.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/42.0_armv7l/adwaita_icon_theme-42.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/42.0_i686/adwaita_icon_theme-42.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/adwaita_icon_theme/42.0_x86_64/adwaita_icon_theme-42.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256({
    aarch64: 'c6dd539659f98a4f83247943715aef136002aa590c4e6e558c89762c60fafefc',
     armv7l: 'c6dd539659f98a4f83247943715aef136002aa590c4e6e558c89762c60fafefc',
       i686: 'f13d05ff2696a2fd7488a7dc4e4e78ad98fe8d7bcf1d63c314e533610a071b6d',
     x86_64: '862aa3d398d4891c8f6923d6c9c2283ebfa9438647a1a25e9172532433db52fb',
  })

  gnome
  no_patchelf

  depends_on 'cantarell_fonts'
  depends_on 'gtk3'
  depends_on 'librsvg'
  depends_on 'gdk_pixbuf'
  depends_on 'vala' => :build
  depends_on 'xdg_base'

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
