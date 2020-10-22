require 'package'

class Vala < Package
  description 'Vala is a programming language that aims to bring modern programming language features to GNOME developers.'
  homepage 'https://wiki.gnome.org/Projects/Vala'
  version '0.50.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/vala/0.50/vala-0.50.1.tar.xz'
  source_sha256 '958d9f06c9c3d7d1b2145512a9bc2a7c6aefbbf0416a04c7a0ecf463f7138f6c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vala-0.50.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '38cb06cd9804c2ce375e637a1ab7e3f65d54fc0bb6d8e12e9af795d2ed99c58b',
     armv7l: '38cb06cd9804c2ce375e637a1ab7e3f65d54fc0bb6d8e12e9af795d2ed99c58b',
       i686: 'a999cbaa519fa66d072c30e6c147ebe94110eef9651732dfe09db6d6318e5c16',
     x86_64: '5bdbef5e4f78303c0ab24333b552e797c7c7db3c1626af8c64b19e433a1cd764',
  })

  depends_on 'flex'
  depends_on 'graphviz'
  depends_on 'libxslt'
  depends_on 'glib'
  depends_on 'dbus'

  def self.build
    system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --disable-valadoc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
