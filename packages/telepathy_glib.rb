require 'package'

class Telepathy_glib < Package
  description 'GLib bindings for the Telepathy D-Bus protocol'
  homepage 'https://telepathy.freedesktop.org'
  @_ver = '0.24.2'
  version @_ver
  compatibility 'all'
  source_url "https://telepathy.freedesktop.org/releases/telepathy-glib/telepathy-glib-#{@_ver}.tar.gz"
  source_sha256 'b0a374d771cdd081125f38c3abd079657642301c71a543d555e2bf21919273f0'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/telepathy_glib-0.24.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/telepathy_glib-0.24.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/telepathy_glib-0.24.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/telepathy_glib-0.24.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '5b6f9a8f1de97a29cb13f82fd8647a4416e974fadfaa4ad3f2c1f5181cecc40c',
     armv7l: '5b6f9a8f1de97a29cb13f82fd8647a4416e974fadfaa4ad3f2c1f5181cecc40c',
       i686: '62adb61813dc3e203125939fdce5d04b2253af1669ccad009160bc6ec066a4b3',
     x86_64: '816ac47c89d6d65c01e40ce4f0b43c6110000bbf0e5a87cfd866904128a5394f'
  })

  depends_on 'dbus_glib'
  depends_on 'libxslt' => ':build'
  depends_on 'vala' => ':build'
  depends_on 'gobject_introspection' => ':build'

  def self.build
    system "env CFLAGS='-flto=auto' CXXFLAGS='-flto=auto' LDFLAGS='-flto=auto' \
      ./configure \
      #{CREW_OPTIONS} \
      --libexecdir=#{CREW_LIB_PREFIX}/telepathy \
      --enable-vala-bindings"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
