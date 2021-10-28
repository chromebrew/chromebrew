require 'package'

class Webkit2gtk_5 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.4'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '00ce2d3f798d7bc5e9039d9059f0c3c974d51de38c8b716f00e94452a177d3fd'

  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'ccache' => :build
  depends_on 'dav1d'
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
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'

  def self.build
    # This builds webkit2gtk5 (which uses gtk4)
    Dir.mkdir 'builddir5'
    Dir.chdir 'builddir5' do
      # -flto breaks x86_64 builds
      # system "env #{CREW_ENV_OPTIONS} \
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS.gsub('-flto', '').gsub('-ffat-lto-objects', '')} \
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
        -DUSE_AVIF=ON \
        -DPYTHON_EXECUTABLE=`which python` \
        .."
    end
    system 'ninja -C builddir5'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir5 install"
  end
end
