require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.50.3'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vala/0.50/vala-0.50.3.tar.xz'
  source_sha256 '6165c1b42beca4856e2fb9a31c5e81949d76fa670e2f0cfc8389ce9b95eca5db'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.3-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.3-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.3-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '6a7d6ae85c7105e34c471b4c3218af328e30e613bafe6fd5ff1a40d8fc9e0d1d',
      armv7l: '6a7d6ae85c7105e34c471b4c3218af328e30e613bafe6fd5ff1a40d8fc9e0d1d',
        i686: 'b86a4c43e82f55cf974e0d60aa664ee719d1f266446167d61e6aa00976c1bd74',
      x86_64: 'a3fe7fae478aa276d36a1e1268b4215257e37c1965dfbeb1d52b7ef4bd47f130',
  })

  depends_on 'flex'
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-valadoc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
