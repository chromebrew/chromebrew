require 'package'

class Webkit2gtk_4 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.4'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '00ce2d3f798d7bc5e9039d9059f0c3c974d51de38c8b716f00e94452a177d3fd'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.4_x86_64/webkit2gtk_4-2.32.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    x86_64: '36c5c54bc95ede8c00fb0b35361c4c20213ab6129a2712c10f91ff9c08128942'
  })

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
  depends_on 'valgrind' => :build
  depends_on 'wayland'
  depends_on 'woff2'
  depends_on 'wpebackend_fdo'

  def self.patch
    open('CMakeLists.txt', 'a') do |f|
      f.puts 'set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC")'
      f.puts 'set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")'
    end
  end

  def self.build
    # This builds webkit2gtk4 (which uses gtk3)
    Dir.mkdir 'builddir4'
    Dir.chdir 'builddir4' do
      # Bubblewrap sandbox breaks on epiphany with
      # bwrap: Can't make symlink at /var/run: File exists
      case ARCH
      when 'x86_64'
        system "#{CREW_ENV_OPTIONS} cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS.gsub('-flto', '').gsub('-ffat-lto-objects', '')} \
          -DLTO_MODE=thin \
          -DCMAKE_LINKER=$(which ld.lld) \
          -DCMAKE_AR=$(which llvm-ar) \
          -DCMAKE_RANLIB=$(which llvm-ranlib) \
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
          -DUSE_AVIF=ON \
          -DPYTHON_EXECUTABLE=`which python` \
          .."
      when 'i686', 'armv7l', 'aarch64'
        system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS.gsub('-flto', '')} \
        -DLTO_MODE=auto \
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
        -DUSE_AVIF=ON \
        -DPYTHON_EXECUTABLE=`which python` \
        .."
      end
    end
    system 'ninja -C builddir4'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir4 install"
  end
end
