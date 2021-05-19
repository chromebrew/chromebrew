require 'package'

class Webkit2gtk_4 < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.32.1'
  version @_ver
  license 'LGPL-2+ and BSD-2'
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '136117317f70f66486f71b8edf5e46f8776403c5d8a296e914b11a36ef836917'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.1_armv7l/webkit2gtk_4-2.32.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.1_armv7l/webkit2gtk_4-2.32.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.1_i686/webkit2gtk_4-2.32.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/webkit2gtk_4/2.32.1_x86_64/webkit2gtk_4-2.32.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c5cbf8c55706aa5253e2bbe5fccd9478103c35ff9ac7c68056099c2a18fe85f',
     armv7l: '6c5cbf8c55706aa5253e2bbe5fccd9478103c35ff9ac7c68056099c2a18fe85f',
       i686: 'ab5cc183f6b51d9bd971c7bac70f617485d66efb0436dfbd941d153d32f5bf8d',
     x86_64: '34d1284e175e6ebdf078ce0ba7e08b404ebb125849470668a35162d2aa2d1daf'
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
        -DUSE_GTK4=OFF \
        -DUSE_SOUP2=ON \
        -DUSE_SYSTEMD=OFF \
        -DUSE_AVIF=ON \
        -DPYTHON_EXECUTABLE=`which python` \
        .."
    end
    system 'ninja -C builddir4'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir4 install"
  end
end
