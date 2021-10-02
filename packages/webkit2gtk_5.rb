require 'package'

class Webkit2gtk_5 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.1'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '136117317f70f66486f71b8edf5e46f8776403c5d8a296e914b11a36ef836917'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.32.1_armv7l/webkit2gtk_5-2.32.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.32.1_armv7l/webkit2gtk_5-2.32.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_5/2.32.1_x86_64/webkit2gtk_5-2.32.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '706890a948d02cb2db17d3f1ef0718710c88ba8900a6bc31cb6905498aa85189',
     armv7l: '706890a948d02cb2db17d3f1ef0718710c88ba8900a6bc31cb6905498aa85189',
     x86_64: '5dfa210eecb769b0b301474ee2bd819f68eda3fa27e1e372a0cb046718675a90'
  })

  depends_on 'atk'
  depends_on 'cairo'
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
      # ccache currently breaks gcc builds of webkit-gtk
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_FNO_LTO_OPTIONS} \
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
