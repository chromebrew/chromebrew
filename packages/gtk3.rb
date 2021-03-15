require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.27'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtk/-/archive/#{@_ver}/gtk-#{@_ver}.tar.bz2"
  # source_url "https://download.gnome.org/sources/gtk/#{@_ver_prelastdot}/gtk-#{@_ver}.tar.xz"
  source_sha256 'dbc3b14ae0d8e44bc8caeac91d62b4d2403a881d837cb4e9bcfb8d138712c3a3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.27-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.27-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.27-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.27-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '840b06f1ccf18e6b85e7944e1af74e9a08385053a46f0277c8f395fa02c20f2a',
     armv7l: '840b06f1ccf18e6b85e7944e1af74e9a08385053a46f0277c8f395fa02c20f2a',
       i686: 'f07416c233166be3cf0777be1745d61ed6f3574137a7918c300779acc39593d8',
     x86_64: 'bdd162ae2fd29f1500e2dd6a7ed7378023b2e20d3af73c42c3017ef10f4d905f'
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
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    @xdg_config_home = ENV['XDG_CONFIG_HOME']
    @gtk3settings = <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-application-prefer-dark-theme = false
      gtk-icon-theme-name = hicolor
      gtk-fallback-icon-theme = gnome
      gtk-font-name = Arial 10
    GTK3_CONFIG_HEREDOC
    unless File.exist?("#{@xdg_config_home}/gtk-3.0/settings.ini")
      puts
      puts 'Adding basic gtk4 settings to XDG_CONFIG_HOME/gtk-3.0/settings.ini'.lightblue
      FileUtils.mkdir_p "#{@xdg_config_home}/gtk-3.0"
      File.write("#{@xdg_config_home}/gtk-3.0/settings.ini", @gtk3settings)
    end
  end
end
