require 'package'

class Gjs < Package
  description 'Javascript Bindings for GNOME'
  @_ver = '1.67.3'
  @_ver_prelastdot = @_ver.rpartition('.')[0]
  version @_ver
  compatibility 'all'
  source_url "https://download.gnome.org/sources/gjs/#{@_ver_prelastdot}/gjs-#{@_ver}.tar.xz"
  source_sha256 '12df0c0ff2dd4c944ad27477ee8053e1363c4ad499542686bba21e06d38c6733'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gjs-1.67.3-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '6ee8b11391aee0245536d1d702b765739b20310df841ca4395fce2d9b07eb532',
     armv7l: '6ee8b11391aee0245536d1d702b765739b20310df841ca4395fce2d9b07eb532',
       i686: 'f8eeea3dd66b93420d99942db1dc355c8b0f36d0201e77ca239186e8de113051',
     x86_64: '0bcdfb345b073565735fbd8b3e76a5cd6d9694590cbd10b217619207b91a3f88'
  })

  depends_on 'cairo'
  depends_on 'gobject_introspection'
  depends_on 'js78'
  depends_on 'dconf'
  depends_on 'gobject_introspection' => ':build'
  depends_on 'dbus' => ':build'

  def self.build
    system "meson #{CREW_MESON_LTO_OPTIONS} \
    -Dinstalled_tests=false \
    -Dskip_dbus_tests=true \
    -Dreadline=disabled \
    builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
