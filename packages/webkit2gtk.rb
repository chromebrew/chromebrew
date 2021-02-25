require 'package'

class Webkit2gtk < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.30.5'
  version @_ver
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 '7d0dab08e3c5ae07bec80b2822ef42e952765d5724cac86eb23999bfed5a7f1f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.5-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'b7124c084ab583574893195e4d295d4fd79c2468770d29ca524474c1a5b8bb33',
     armv7l: 'b7124c084ab583574893195e4d295d4fd79c2468770d29ca524474c1a5b8bb33',
       i686: 'b6f3fac281c5ddfed66957f210ba226b422b8ffe1935c844d4e9934a32347f78',
     x86_64: '6c4dd4d6c1625f87950d8d38e99398b670edf1deb758f4efdf53dca7b9b1e57d'
  })

  depends_on 'cairo'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gtk3'
  depends_on 'harfbuzz'
  depends_on 'gtk_doc' => ':build'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'libsoup'
  depends_on 'libwpe'
  depends_on 'wpebackend_fdo'
  depends_on 'libsecret'
  depends_on 'enchant'
  depends_on 'libnotify'
  depends_on 'hyphen'
  depends_on 'woff2'
  depends_on 'bubblewrap'
  depends_on 'xdg_dbus_proxy'
  depends_on 'libseccomp'
  depends_on 'openjpeg'
  depends_on 'libsoup'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # -flto breaks x86_64 builds
      # system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_SKIP_RPATH=ON \
        -DPORT=GTK \
        -DENABLE_GTKDOC=OFF \
        -DENABLE_MINIBROWSER=ON \
        -DUSE_SYSTEMD=OFF \
        -DENABLE_WAYLAND_TARGET=ON \
        -DUSE_GTK4=OFF \
        -DENABLE_VIDEO=OFF \
        -DENABLE_WEB_AUDIO=OFF \
        -DENABLE_GLES2=ON \
        -DENABLE_INTROSPECTION=ON \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
