require 'package'

class Webkit2gtk_4 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.0'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '9d7df4dae9ada2394257565acc2a68ace9308c4c61c3fcc00111dc1f11076bf0'

  binary_url({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/webkit2gtk_4-2.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/webkit2gtk_4-2.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/webkit2gtk_4-2.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/webkit2gtk_4-2.32.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'be723ff23a31c85ad8c5dea8cadbeaac12aa17810f6bf448999b46f008a30034',
     armv7l: 'be723ff23a31c85ad8c5dea8cadbeaac12aa17810f6bf448999b46f008a30034',
       i686: 'b0bd0f98543cee946931bd3726a0a7d10d709006d930f28ecb322086876567a2',
     x86_64: '2bfe6213119d1bbaa98634a99e0390a222ea95c30ef1d329d0b17d6df0aaf89b'
  })

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'ccache' => :build
  depends_on 'enchant'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gobject_introspection' => :build
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk3'
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz'
  depends_on 'hyphen'
  depends_on 'libgcrypt'
  depends_on 'libjpeg'
  depends_on 'libnotify'
  depends_on 'libpng'
  depends_on 'libsecret'
  depends_on 'libsoup'
  depends_on 'libsoup2'
  depends_on 'libwebp'
  depends_on 'libwpe'
  depends_on 'libx11'
  depends_on 'libxcomposite'
  depends_on 'libxdamage'
  depends_on 'libxrender'
  depends_on 'libxslt'
  depends_on 'libxt'
  depends_on 'mesa'
  depends_on 'openjpeg'
  depends_on 'pango'
  depends_on 'wayland'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'

  def self.build
    # This builds webkit2gtk4 (which uses gtk3)
    Dir.mkdir 'builddir4'
    Dir.chdir 'builddir4' do
      # -flto breaks x86_64 builds
      # system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
        -DCMAKE_SKIP_RPATH=ON \
        -DENABLE_BUBBLEWRAP_SANDBOX=OFF \
        -DENABLE_GAMEPAD=OFF \
        -DENABLE_GLES2=ON \
        -DENABLE_GTKDOC=OFF \
        -DENABLE_INTROSPECTION=ON \
        -DENABLE_MINIBROWSER=ON \
        -DENABLE_VIDEO=ON \
        -DENABLE_WAYLAND_TARGET=ON \
        -DENABLE_WEB_AUDIO=OFF \
        -DPORT=GTK \
        -DUSE_GTK4=OFF \
        -DUSE_SOUP2=ON \
        -DUSE_SYSTEMD=OFF \
        .."
    end
    system 'ninja -C builddir4'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir4 install"
  end
end
