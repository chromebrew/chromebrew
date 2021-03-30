require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.28'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtk/-/archive/#{@_ver}/gtk-#{@_ver}.tar.bz2"
  # source_url "https://download.gnome.org/sources/gtk/#{@_ver_prelastdot}/gtk-#{@_ver}.tar.xz"
  source_sha256 'ab8e2799c71f4ff5052fade351a3a035d60d7d357035788227bf5e6270cde448'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.28-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'ed7944ce5c9de772f04b435c5b3b4a764ba40c50396d618c2bc2d47d8e4d12c5',
     armv7l: 'ed7944ce5c9de772f04b435c5b3b4a764ba40c50396d618c2bc2d47d8e4d12c5',
       i686: '198994411219b4ebd29872901bb0c32f57c5a018d6fff60967be01c27fd3889a',
     x86_64: '5b45f67de167c933b7e2b5fd138eac56ebe1405fd2d70e3036980df1fc684987'
  })

  depends_on 'adwaita_icon_theme'
  depends_on 'atk'
  depends_on 'at_spi2_atk'
  depends_on 'cairo'
  depends_on 'cantarell_fonts'
  depends_on 'cups'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gnome_icon_theme'
  depends_on 'gobject_introspection'
  depends_on 'graphene'
  depends_on 'graphite'
  depends_on 'harfbuzz'
  depends_on 'hicolor_icon_theme'
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libdeflate'
  depends_on 'libepoxy'
  depends_on 'libx11'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxi'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'
  depends_on 'libxrandr'
  depends_on 'pango'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'wayland'
  depends_on 'xdg_base'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
      -Dbroadway_backend=true \
      -Ddemos=false \
      -Dexamples=false \
      -Dgtk_doc=false \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
    @gtk3settings = <<~GTK3_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-fallback-icon-theme = gnome
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
      gtk-application-prefer-dark-theme = false
    GTK3_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/gtk-3.0"
    File.write("#{CREW_DEST_PREFIX}/etc/gtk-3.0/settings.ini", @gtk3settings)
  end

  def self.postinstall
    # generate schemas
    system "#{CREW_PREFIX}/bin/glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "#{CREW_PREFIX}/bin/update-mime-database #{CREW_PREFIX}/share/mime"
    # update icon cache
    system "#{CREW_PREFIX}/bin/gtk-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*"
  end
end
