require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  @_ver = '3.24.25'
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gtk+/3.24/gtk+-#{@_ver}.tar.xz"
  source_sha256 `curl -Ls https://download.gnome.org/sources/gtk+/3.24/gtk%2B-3.24.25.sha256sum | tail -n1 | cut -d ' ' -f1`

  depends_on 'cups'
  depends_on 'at_spi2_atk'
  depends_on 'gcc10' => :build
  depends_on 'gnome_icon_theme'
  depends_on 'gobject_introspection'
  depends_on 'gdk_pixbuf'
  depends_on 'graphene'
  depends_on 'hicolor_icon_theme'
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libepoxy'
  depends_on 'libxkbcommon'
  depends_on 'llvm' => :build
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'xdg_base'
  depends_on 'atk'
  depends_on 'graphite'

  def self.build
    system "env CFLAGS='-fuse-ld=lld' CXXFLAGS='-fuse-ld=lld' \
            meson #{CREW_MESON_LTO_OPTIONS} \
            -Dbroadway_backend=true \
            -Dgtk_doc=false \
            -Ddemos=false \
            -Dexamples=false \
            builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    system "sed -i 's,null,,g'  #{CREW_DEST_LIB_PREFIX}/pkgconfig/gtk*.pc"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    
    puts 'Performing configuration...'
    FileUtils.mkdir_p("#{HOME}/.config/gtk-3.0")
    @ini = "#{HOME}/.config/gtk-3.0/settings.ini"
    @file = <<~EOF
      [Settings]
      gtk-application-prefer-dark-theme = false
      gtk-icon-theme-name = hicolor
      gtk-fallback-icon-theme = gnome
      gtk-font-name = Arial 10
    EOF
    File.write(@ini, @file) unless File.exist?(@ini)
  end
end
