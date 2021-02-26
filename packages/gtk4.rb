require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  version '4.1.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk/4.1/gtk-4.1.1.tar.xz'
  source_sha256 'f7e1789f6c637b091cffb17de08bd9c3986543282eecdff0750dd04f1673b737'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'dcce3aeb6954b2010a867f2bf84b11995d6d0433a1ece96313ee36d27af4819c',
     armv7l: 'dcce3aeb6954b2010a867f2bf84b11995d6d0433a1ece96313ee36d27af4819c',
       i686: '182fa221219f0a2b25b5ebe902e86dde0ed09e3e741bb1e52acdd120e8bcb308',
     x86_64: '81fbb2bd61ff6c1f0729f686e9c1a21f39c24bfaf8d2bd0a92adb929e3f32475'
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
    -Dsassc=enabled \
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
