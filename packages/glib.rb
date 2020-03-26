require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.64.1'
  source_url 'https://ftp.acc.umu.se/pub/gnome/sources/glib/2.64/glib-2.64.1.tar.xz'
  source_sha256 '17967603bcb44b6dbaac47988d80c29a3d28519210b28157c2bd10997595bbc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.64.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.64.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.64.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.64.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ba601edad8d81993f486184431f1951e47e8300366e7655c2ea164e923fcc056',
     armv7l: 'ba601edad8d81993f486184431f1951e47e8300366e7655c2ea164e923fcc056',
       i686: '532128e2b88f76fd80cad43e0804e5d6549dfe02f21579158261357c9a4be159',
     x86_64: '9f0d347094230086b43f7535bd980d1a0efb4b9e5704e74acff9c1eb584dcd04',
  })

  depends_on 'util_linux'
  depends_on 'six'

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Dinternal_pcre=true builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
