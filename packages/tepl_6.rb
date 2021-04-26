require 'package'

class Tepl_6 < Package
  description 'Library that eases the development of GtkSourceView-based text editors and IDEs'
  homepage 'https://wiki.gnome.org/Projects/Tepl'
  version '5.99.0-d61f'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/tepl/-/archive/d61f4f8c1c17299b75c2dffc67df81a25b9ed243/tepl-d61f4f8c1c17299b75c2dffc67df81a25b9ed243.tar.bz2'
  source_sha256 '954c9e27d017bddc99788911019ca223222fd1c59e383c4e21be84e62906b662'

  binary_url({
    aarch64: 'https://github.com/chromebrew/binaries/raw/main/armv7l/tepl_6-5.99.0-d61f-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/chromebrew/binaries/raw/main/armv7l/tepl_6-5.99.0-d61f-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/chromebrew/binaries/raw/main/i686/tepl_6-5.99.0-d61f-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/chromebrew/binaries/raw/main/x86_64/tepl_6-5.99.0-d61f-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '928c126e8c0d2a87a6778dbe9d60fd1a31a0e3160ea384d5c0e36444b4936de9',
     armv7l: '928c126e8c0d2a87a6778dbe9d60fd1a31a0e3160ea384d5c0e36444b4936de9',
       i686: 'f98b0034642f3433f036107d710f7c466701f94cea809e83908ada8c98305bc2',
     x86_64: 'f479f11290e064ad429f4708c22cea0ce498dfb440278e98be7bbfcb751ece1b'
  })

  depends_on 'amtk'
  depends_on 'cairo'
  depends_on 'glib'
  depends_on 'gtk3'
  depends_on 'gtksourceview'
  depends_on 'gobject_introspection' => :build
  depends_on 'gtk_doc' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
