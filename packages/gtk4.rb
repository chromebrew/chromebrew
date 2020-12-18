require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  version '4.0'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://download.gnome.org/sources/gtk/4.0/gtk-4.0.0.tar.xz'
    source_sha256 'd46cf5b127ea27dd9e5d2ff6ed500cb4067eeb2cb1cd2c313ccde8013b0b9bf9'
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
    depends_on 'llvm' => :build
    depends_on 'shared_mime_info'
    depends_on 'six' => :build
    depends_on 'xdg_base'
    depends_on 'pygments' => :build
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f7201d1c2146a2183f6235b22697d54c87d2afc271c08a22d4e4d4511d9d173c',
     armv7l: 'f7201d1c2146a2183f6235b22697d54c87d2afc271c08a22d4e4d4511d9d173c',
     x86_64: '64ae34d9c3db55c399b26ae37824d5a3c6023e96cf3552d0d3924c1899af1143',
  })

  def self.build
    ENV['CFLAGS'] = '-fuse-ld=lld'
    ENV['CXXFLAGS'] = '-fuse-ld=lld'
    system "meson #{CREW_MESON_OPTIONS} \
    -Dbroadway-backend=true \
    -Ddemos=false\
    -Dbuild-examples=false \
    -Dbuild-tests=false \
    -Dgraphene:default_library=both \
    -Dlibsass:default_library=both \
    -Dmutest:default_library=both \
    -Dsassc:default_library=both \
    build"
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
    puts "mkdir #{HOME}/.config/gtk-4.0".lightblue
    puts "cat << 'EOF' > #{HOME}/.config/gtk-4.0/settings.ini
[Settings]
gtk-application-prefer-dark-theme = false
gtk-icon-theme-name = hicolor
gtk-fallback-icon-theme = gnome
gtk-font-name = Arial 10
EOF".lightblue
    puts
  end
end
