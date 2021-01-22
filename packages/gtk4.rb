require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  version '4.0.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/gtk/4.0/gtk-4.0.2.tar.xz'
  source_sha256 '626707ac6751426ed76fed49c5b2d052dfee45757ce3827088ba87ca7f1dbc84'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '80abb64172b377862591c608196ac945bd1f9ba81e2304d180d4f1129cb310f7',
      armv7l: '80abb64172b377862591c608196ac945bd1f9ba81e2304d180d4f1129cb310f7',
        i686: 'cdbb821b6bf8d6965022b0f8e8b52c750db13c40134a1704cf27bfcd753087cb',
      x86_64: '496f28133a2541843b4cdd08db8a941c7513a19ba9621212e635bf3ec6bc0284',
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
  depends_on 'llvm' => :build
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
    if !File.exists?("#{HOME}/.config/gtk-4.0/settings.ini")
      puts
      puts "Adding basic gtk4 settings to ~/.config/gtk-4.0/settings.ini".lightblue
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
