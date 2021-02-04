require 'package'

class Webkit2gtk < Package
  description 'Web content engine for GTK'
  homepage 'https://webkitgtk.org'
  @_ver = '2.30.4'
  version @_ver
  compatibility 'all'
  source_url "https://webkitgtk.org/releases/webkitgtk-#{@_ver}.tar.xz"
  source_sha256 'd595a37c5001ff787266b155e303a5f2e5b48a6d466f2714c2f30c11392f7b24'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/webkit2gtk-2.30.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '436805dc8bc10da1f84fd9874fb79b98ee56b433e78eba6b668e523c28c87f83',
     armv7l: '436805dc8bc10da1f84fd9874fb79b98ee56b433e78eba6b668e523c28c87f83',
       i686: '754535d0b5e01e458052800e28f9ccdf6b5f10a07c8c08903201f369ef19eb8d',
     x86_64: '415da1b2619e82937d52364e16308d72f1f6e99c4305443f11e0b97ed5bf3c6b'
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
  depends_on 'ccache' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      # -flto breaks x86_64 builds
      # system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
      # system "env PATH=#{CREW_LIB_PREFIX}/ccache/bin:#{CREW_PREFIX}/bin:/usr/bin:/bin \
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
