require 'package'

class Webkit2gtk_5 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.0'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '9d7df4dae9ada2394257565acc2a68ace9308c4c61c3fcc00111dc1f11076bf0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk_5-2.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk_5-2.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk_5-2.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk_5-2.32.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0d49b1141892ec63b2b43c682aa4feb3c5b64dc04bfea08ec9f9c0d2c6fb583d',
     armv7l: '0d49b1141892ec63b2b43c682aa4feb3c5b64dc04bfea08ec9f9c0d2c6fb583d',
       i686: 'f1481e0a9cdf9df4308320777971dc6c168344aa9488169caad6c4c6549c56d4',
     x86_64: '11d1d701c17bdf1f7de0e4d0df094dd6342195134cf153b22b125ec1dfd58ead'
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
  depends_on 'graphene'
  depends_on 'gst_plugins_base'
  depends_on 'gstreamer'
  depends_on 'gtk4'
  depends_on 'gtk_doc' => :build
  depends_on 'harfbuzz'
  depends_on 'hyphen'
  depends_on 'libgcrypt'
  depends_on 'libjpeg'
  depends_on 'libnotify'
  depends_on 'libpng'
  depends_on 'libsecret'
  depends_on 'libsoup'
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
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'

  def self.build
    # This builds webkit2gtk5 (which uses gtk4)
    Dir.mkdir 'builddir5'
    Dir.chdir 'builddir5' do
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
        -DUSE_GTK4=ON \
        -DUSE_SOUP2=OFF \
        -DUSE_SYSTEMD=OFF \
        .."
    end
    system 'ninja -C builddir5'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir5 install"
  end
end
