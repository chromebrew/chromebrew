require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.26'
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gtk+/3.24/gtk+-#{@_ver}.tar.xz"
  source_sha256 '2cc1b2dc5cad15d25b6abd115c55ffd8331e8d4677745dd3ce6db725b4fff1e9'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.26-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.26-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.26-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.26-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f53f6e97f2929af71f497f14869d83ce20f62469aa387d460b43c94105ecd0d1',
     armv7l: 'f53f6e97f2929af71f497f14869d83ce20f62469aa387d460b43c94105ecd0d1',
       i686: '9402509ba5d7af3da372b804e28f9c8213768e3bc3a16f811162dd278e0900d4',
     x86_64: '0e594d1b3661938b5d586670588ffd0b3a6327e697fc01a68e77d101192d9962'
  })

  depends_on 'cups'
  depends_on 'at_spi2_atk'
  depends_on 'gnome_icon_theme'
  depends_on 'gobject_introspection'
  depends_on 'gdk_pixbuf'
  depends_on 'graphene'
  depends_on 'hicolor_icon_theme'
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libepoxy'
  depends_on 'libxkbcommon'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'xdg_base'
  depends_on 'atk'
  depends_on 'graphite'
  depends_on 'libdeflate'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
            -Dbroadway_backend=true \
            -Dgtk_doc=false \
            -Ddemos=false \
            -Dexamples=false \
            builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
    @file = <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-application-prefer-dark-theme = false
      gtk-icon-theme-name = hicolor
      gtk-fallback-icon-theme = gnome
      gtk-font-name = Arial 10
    GTK3_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
    FileUtils.mkdir_p("#{CREW_DEST_HOME}/.config/gtk-3.0")
    File.write("#{CREW_DEST_HOME}/.config/gtk-3.0/settings.ini", @file)
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
  end
end
