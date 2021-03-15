require 'package'

class Adwaita_icon_theme < Package
  description 'Theme consisting of a set of icons for GTK+'
  homepage 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme'
  version '3.38.0-c5be'
  compatibility 'x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/adwaita-icon-theme/-/archive/c5bed6840332a7539b175feb4ec7ecf957fb1399/adwaita-icon-theme-c5bed6840332a7539b175feb4ec7ecf957fb1399.tar.bz2'
  source_sha256 '54d67549cb7b295dd649460a22af9d2f436dd73386068eb20ce888f6f4bee0fb'

  binary_url({
    i686: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-c5be-chromeos-i686.tar.xz',
  x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/adwaita_icon_theme-3.38.0-c5be-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'f5e0d629d2b99eb18cfa2a6d991a33e0efb4efe206b6510d884bf8d96ee3d9af',
  x86_64: 'bd03ca46fc6310ea449362b95e0032e800fdda4f86252e02f64502407cd29adc'
  })

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
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
