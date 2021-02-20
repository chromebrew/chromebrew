require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  version '4.1.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk/4.1/gtk-4.1.0.tar.xz'
  source_sha256 '973f651722a847e91e12be0a1c1c610aae0961f2f8d55c5d1fa39e17267d7ada'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '660d77d46cd96bc0a9c444d0731e84c6a0e9d36b5df9b27f0214891f5e2c99ca',
     armv7l: '660d77d46cd96bc0a9c444d0731e84c6a0e9d36b5df9b27f0214891f5e2c99ca',
       i686: 'e800d434423310eee5e81f1973ec51be376a4e3b0cac040da68da4c5e53919ea',
     x86_64: '873b3c26ecaf958476f782ae62c10291649f41e1d533aa6381340617beb5aae3'
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
  depends_on 'pygments' => :build

  def self.patch
    case ARCH
    when 'i686'
      system "sed -i 's,#include <fcntl.h>,#include <linux/fcntl.h>,' gdk/wayland/cursor/os-compatibility.c"
      system "sed -i 's/#define HAVE_MEMFD_CREATE/#define HAVE_MEMFD_CREATE_NO/' gdk/wayland/cursor/os-compatibility.c"
    end
  end

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
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
    unless File.exist?("#{HOME}/.config/gtk-4.0/settings.ini")
      puts
      puts 'Adding basic gtk4 settings to ~/.config/gtk-4.0/settings.ini'.lightblue
      FileUtils.mkdir_p "#{HOME}/.config/gtk-4.0"
      system "cat << 'EOF' > #{HOME}/.config/gtk-4.0/settings.ini
[Settings]
gtk-icon-theme-name = Adwaita
gtk-theme-name = Adwaita
gtk-font-name = Arimo 10
EOF"
    end
  end
end
