require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.25'
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gtk+/3.24/gtk+-#{@_ver}.tar.xz"
  source_sha256 '87e26b111d3b8a85ff218980a56f3e814257b8dd11e5c4d9a2803b423b08297c'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.25-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.25-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.25-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.25-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '2ac48ac4e7afae50082113a5ee02887e8e275a63caa551308009e4778eef8509',
     armv7l: '2ac48ac4e7afae50082113a5ee02887e8e275a63caa551308009e4778eef8509',
       i686: '6295abdfb026ea717b3e46b5cf86b42228e223c2e92160263cc36974eaf0a340',
     x86_64: '274d6fd9d16cd2a4dc60a07b9212fb643851c37fe788f373ba46b644ba5272dc'
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
