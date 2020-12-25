require 'package'

class Gtk3 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.24.24'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk+/3.24/gtk+-3.24.24.tar.xz'
  source_sha256 'cc9d4367c55b724832f6b09ab85481738ea456871f0381768a6a99335a98378a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.24-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.24-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.24-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk3-3.24.24-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e210c917b0effc58d588dacda8f8db7897ce9699323001a21f732d053ef5c285',
     armv7l: 'e210c917b0effc58d588dacda8f8db7897ce9699323001a21f732d053ef5c285',
       i686: 'e71c8b765f76138543aca2cdbbc57904da3dbe6360a51f586b5b6dc6f7d2b599',
     x86_64: '7ecd9650e74bce60e27df07be49b89aee56da89795b63ac3f894aac8542ec69a',
  })

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

  def self.build
    # The lld linker allows linking against system ChromeOS libs.
    ENV['CFLAGS'] = '-fuse-ld=lld'
    ENV['CXXFLAGS'] = '-fuse-ld=lld'
    system "meson #{CREW_MESON_OPTIONS} -Dbroadway_backend=true -Dgtk_doc=false -Ddemos=false -Dexamples=false build"
    system 'meson configure build'
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end

  def self.postinstall
    # generate schemas
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "update-mime-database #{CREW_PREFIX}/share/mime"
    puts
    puts "To add basic settings, execute the following:".lightblue
    puts "mkdir #{HOME}/.config/gtk-3.0".lightblue
    puts "cat << 'EOF' > #{HOME}/.config/gtk-3.0/settings.ini
[Settings]
gtk-application-prefer-dark-theme = false
gtk-icon-theme-name = hicolor
gtk-fallback-icon-theme = gnome
gtk-font-name = Arial 10
EOF".lightblue
    puts
  end
end
