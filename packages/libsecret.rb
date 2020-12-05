require 'package'

class Libsecret < Package
  description 'GObject based library for accessing the Secret Service API.'
  homepage 'https://github.com/GNOME/libsecret'
  version '0.20.4'
  compatibility 'all'
  source_url 'https://github.com/GNOME/libsecret/archive/0.20.4.tar.gz'
  source_sha256 'ca34e69b210df221ae5da6692c2cb15ef169bb4daf42e204442f24fdb0520d4b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsecret-0.20.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72e98cbae2d269061a3d2ca137a8437642d9cc72a130f02fecddd405dd968c95',
     armv7l: '72e98cbae2d269061a3d2ca137a8437642d9cc72a130f02fecddd405dd968c95',
       i686: '3a58950489de1b2dc1cdb57c81f73b6aca116dac47e13ee486c0bbf513c54dff',
     x86_64: '8d4f30362b10c787837da9ed3568d27933f22cea9f6b605ad5f8fec20b5e755d',
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'libgcrypt' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} -Dgtk_doc=false -Dmanpage=false build"
    system 'meson configure build'
    system 'ninja -v -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
