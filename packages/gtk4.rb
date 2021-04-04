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
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.2.0-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.2.0-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.2.0-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtk4-4.2.0-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'e6d12870ed535be19d04aff0eb4659e94728faa4464fd1d26de0dc51fec049d2',
     armv7l: 'e6d12870ed535be19d04aff0eb4659e94728faa4464fd1d26de0dc51fec049d2',
       i686: '26bba0fa27efbc129c81077260ae15adc03cd02dd4ebf664fb3b99082816510d',
     x86_64: '68c169e9112531c9fc41f9bed15a542867500846a16eedc6f103cfbcd99c668b'
  })

  depends_on 'adwaita_icon_theme'
  depends_on 'at_spi2_atk'
  depends_on 'avahi'
  depends_on 'cairo'
  depends_on 'cantarell_fonts'
  depends_on 'cups'
  depends_on 'dav1d'
  depends_on 'dbus'
  depends_on 'elfutils'
  depends_on 'eudev'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gnome_icon_theme'
  depends_on 'gobject_introspection'
  depends_on 'graphene'
  depends_on 'graphite'
  depends_on 'gsm'
  depends_on 'gst_plugins_bad'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'harfbuzz'
  depends_on 'hicolor_icon_theme'
  depends_on 'intel_media_sdk' if ARCH.eql?('x86_64')
  depends_on 'iso_codes'
  depends_on 'json_glib'
  depends_on 'libaom'
  depends_on 'libbluray'
  depends_on 'libdeflate'
  depends_on 'libdrm'
  depends_on 'libepoxy'
  depends_on 'libgcrypt'
  depends_on 'libgpgerror'
  depends_on 'libgudev'
  depends_on 'libjpeg'
  depends_on 'libmfx' if ARCH.eql?('x86_64') || ARCH.eql?('i686')
  depends_on 'libmodplug'
  depends_on 'libmp3lame'
  depends_on 'libogg'
  depends_on 'libopencoreamr'
  depends_on 'libopus'
  depends_on 'libpng'
  depends_on 'libsass' if ARCH.eql?('x86_64')
  depends_on 'libsoup2'
  depends_on 'libsoxr'
  depends_on 'libssh'
  depends_on 'libtheora'
  depends_on 'libtiff'
  depends_on 'libunwind'
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'libvorbis'
  depends_on 'libvpx'
  depends_on 'libwebp'
  depends_on 'libx11'
  depends_on 'libx264'
  depends_on 'libx265'
  depends_on 'libxau'
  depends_on 'libxcb'
  depends_on 'libxcomposite'
  depends_on 'libxcursor'
  depends_on 'libxdamage'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxi'
  depends_on 'libxinerama'
  depends_on 'libxkbcommon'
  depends_on 'libxrandr'
  depends_on 'libxrender'
  depends_on 'libxshmfence'
  depends_on 'libxvid'
  depends_on 'libxxf86vm'
  depends_on 'lzo'
  depends_on 'mesa'
  depends_on 'openjpeg'
  depends_on 'orc'
  depends_on 'pango'
  depends_on 'pcre'
  depends_on 'pixman'
  depends_on 'pygments' => :build
  depends_on 'rav1e'
  depends_on 'rest'
  depends_on 'shared_mime_info'
  depends_on 'six' => :build
  depends_on 'snappy'
  depends_on 'speex'
  depends_on 'srt'
  depends_on 'util_linux'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'xdg_base'
  depends_on 'zeromq'

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
