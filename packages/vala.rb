require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.51.2'
  compatibility 'all'
  source_url 'https://download.gnome.org/core/40/40.beta/sources/vala-0.51.2.tar.xz'
  source_sha256 'a1db75bfdc7e8ffa08d2c4a8a4b561fb24f3e9516d712531b8d14a74695a37b2'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.51.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.51.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.51.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.51.2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '322bf1ba49dad18e92a07ff0371d1ecf5ef50658cff4854c866484d0636209cd',
     armv7l: '322bf1ba49dad18e92a07ff0371d1ecf5ef50658cff4854c866484d0636209cd',
       i686: '5637fb96d07390df272e5d0864b91442bb9aac4b934d69215eafc4e0e81fdca4',
     x86_64: '977183724a7552da5c055540d01d702c0887ecd1b0cdb05220718ce964037042'
  })

  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' \
    LDFLAGS='-pipe -flto=auto' \
      ./configure #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --disable-valadoc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
