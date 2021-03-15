require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  @_ver = '4.1.2'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtk/-/archive/#{@_ver}/gtk-#{@_ver}.tar.bz2"
  # source_url "https://download.gnome.org/sources/gtk/#{@_ver_prelastdot}/gtk-#{@_ver}.tar.xz"
  source_sha256 '64b042592ba48c63535a47ed087d161290620e1de9e577ff89ea3afabf1a4edb'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.1.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f04e726a8c2a71d04c1a274a67b0727aa6ae318b40d9325f20546ca29064e37e',
     armv7l: 'f04e726a8c2a71d04c1a274a67b0727aa6ae318b40d9325f20546ca29064e37e',
       i686: '690f527ac11a4af784b299159350323e726a5be18b3443fabdfc41f83dcd10a4',
     x86_64: '3d715f42be186839b936929deaec180a3bf13f3fb2f7e89dc21421d6b19988fa'
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
    @xdg_config_home = ENV['XDG_CONFIG_HOME']
    @gtk4settings = <<~GTK4_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-theme-name = Adwaita
      gtk-font-name = Arimo 10
    GTK4_CONFIG_HEREDOC
    unless File.exist?("#{@xdg_config_home}/gtk-4.0/settings.ini")
      puts
      puts 'Adding basic gtk4 settings to XDG_CONFIG_HOME/gtk-4.0/settings.ini'.lightblue
      FileUtils.mkdir_p "#{@xdg_config_home}/gtk-4.0"
      File.write("#{@xdg_config_home}/gtk-4.0/settings.ini", @gtk4settings)
    end
  end
end
