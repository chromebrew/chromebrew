require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.56.1'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.56/glib-2.56.1.tar.xz'
  source_sha256 '40ef3f44f2c651c7a31aedee44259809b6f03d3d20be44545cd7d177221c0b8d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c204eac72fd82ad0aa5c58be276960f98f05ff1edca0beea76dd60ecedc8adbf',
     armv7l: 'c204eac72fd82ad0aa5c58be276960f98f05ff1edca0beea76dd60ecedc8adbf',
       i686: '14f14d855b87c7c062b850d91b4de2deb6d92fef8d252938631820a43d468d7c',
     x86_64: 'fd6aea5f310ed045f3e9c132af14d11e63c5d50e04871369eb4888dfef9aee66',
  })

  depends_on 'libffi'
  depends_on 'util_linux'
  depends_on 'python27'

  def self.build
    system "./configure",
    "--prefix=#{CREW_PREFIX}",
    "--libdir=#{CREW_LIB_PREFIX}",
    "--with-pcre"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
