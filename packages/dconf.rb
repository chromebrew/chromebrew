require 'package'

class Dconf < Package
  description 'The DConf package contains a low-level configuration system.'
  homepage 'https://wiki.gnome.org/Projects/dconf'
  version '0.28.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/dconf/0.28/dconf-0.28.0.tar.xz'
  source_sha256 '61d3b3865ef58b729c3b39aa0979f886c014aa8362f93dcfc74bf5648ed9c742'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.28.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.28.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.28.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dconf-0.28.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3c83656c8b7a90338c2541e382f04ffc4980939aeb7950c34a1c9ddeff8b3543',
     armv7l: '3c83656c8b7a90338c2541e382f04ffc4980939aeb7950c34a1c9ddeff8b3543',
       i686: '145346b92e7fc48399c9b0d60ebe5ccca0ad38e62ab090aeb9aecb04fda62656',
     x86_64: 'f8c04c675b235a94baea2b9dce74c7d36fa493a79963c41b708fdaa4944e0124',
  })

  depends_on 'dbus'  => :build
  depends_on 'gtk_doc' => :build
  depends_on 'glib'  # version 2
  depends_on 'meson'  => :build
  depends_on 'vala'  => :build

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end

end
