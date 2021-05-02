require 'package'

class Gtk4 < Package
  description 'GTK+ is a multi-platform toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk4/'
  @_ver = '4.2.0'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version "#{@_ver}-1"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://gitlab.gnome.org/GNOME/gtk/-/archive/#{@_ver}/gtk-#{@_ver}.tar.bz2"
  source_sha256 'ea817483d35cd5f5d949a61b15c904ee3157fe5befb98e084a241921562f1838'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.2.0-1_armv7l/gtk4-4.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.2.0-1_armv7l/gtk4-4.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.2.0-1_i686/gtk4-4.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/gtk4/4.2.0-1_x86_64/gtk4-4.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e6d12870ed535be19d04aff0eb4659e94728faa4464fd1d26de0dc51fec049d2',
     armv7l: 'e6d12870ed535be19d04aff0eb4659e94728faa4464fd1d26de0dc51fec049d2',
       i686: '26bba0fa27efbc129c81077260ae15adc03cd02dd4ebf664fb3b99082816510d',
     x86_64: '68c169e9112531c9fc41f9bed15a542867500846a16eedc6f103cfbcd99c668b'
  })

  # L = Logical Dependency, R = Runtime Dependency
  depends_on 'docbook' => :build
  depends_on 'gobject_introspection' => :build
  depends_on 'intel_media_sdk' => :build if ARCH.eql?('x86_64')
  depends_on 'iso_codes' => :build
  depends_on 'mesa' => :build
  depends_on 'py3_pygments' => :build # Is this needed?
  depends_on 'py3_six' => :build # Is this needed?
  depends_on 'vulkan_headers' => :build
  depends_on 'adwaita_icon_theme' # L
  depends_on 'cantarell_fonts' # L
  depends_on 'gnome_icon_theme' # L
  depends_on 'hicolor_icon_theme' # L
  depends_on 'shared_mime_info' # L
  depends_on 'xdg_base' # L
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'ffmpeg' # R
  depends_on 'fontconfig' # R
  depends_on 'fribidi' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'graphene' # R
  depends_on 'gst_plugins_bad' # R
  depends_on 'gst_plugins_base' # R
  depends_on 'gstreamer' # R
  depends_on 'harfbuzz' # R
  depends_on 'json_glib' # R
  depends_on 'libepoxy' # R
  depends_on 'libmfx' if ARCH.eql?('i686') # R
  depends_on 'libsass' if ARCH.eql?('x86_64') # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxcursor' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxi' # R
  depends_on 'libxinerama' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxrandr' # R
  depends_on 'pango' # R
  depends_on 'rest' # R
  depends_on 'vulkan_icd_loader' # R
  depends_on 'wayland' # R

  def self.patch
    case ARCH
    when 'i686'
      system "sed -i 's,#include <fcntl.h>,#include <linux/fcntl.h>,' gdk/wayland/cursor/os-compatibility.c"
      system "sed -i 's/#define HAVE_MEMFD_CREATE/#define HAVE_MEMFD_CREATE_NO/' gdk/wayland/cursor/os-compatibility.c"
    end
  end

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Dbroadway-backend=true \
      -Dbuild-examples=false \
      -Dbuild-tests=false \
      -Ddemos=false\
      -Dgraphene:default_library=both \
      -Dlibsass:default_library=both \
      -Dmutest:default_library=both \
      -Dsassc:default_library=both \
      -Dsassc=enabled \
      build"
    system 'meson configure build'
    system 'ninja -C build'
    @gtk4settings = <<~GTK4_CONFIG_HEREDOC
      [Settings]
      gtk-icon-theme-name = Adwaita
      gtk-theme-name = Adwaita
      gtk-font-name = Cantarell 11
    GTK4_CONFIG_HEREDOC
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/gtk-4.0"
    File.write("#{CREW_DEST_PREFIX}/etc/gtk-4.0/settings.ini", @gtk4settings)
  end

  def self.postinstall
    # generate schemas
    system "#{CREW_PREFIX}/bin/glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    # update mime database
    system "#{CREW_PREFIX}/bin/update-mime-database #{CREW_PREFIX}/share/mime"
    # update icon cache
    system "#{CREW_PREFIX}/bin/gtk4-update-icon-cache -ft #{CREW_PREFIX}/share/icons/*"
  end
end
