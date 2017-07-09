require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib/'
  version '2.40.2'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.40/glib-2.40.2.tar.xz'
  source_sha256 'e8ff8af2950897e805408480c454c415d1eade4e670ec5fb507f5e5853726c7a'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/glib-2.40.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/glib-2.40.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/glib-2.40.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/glib-2.40.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0cb6d4ea1398bceb72fd4ab673d8aa0a49ed3a567205ca0284e94b1e654146d0',
     armv7l: '0cb6d4ea1398bceb72fd4ab673d8aa0a49ed3a567205ca0284e94b1e654146d0',
       i686: '13d580fb427b9b508bfd7d31a9229df40fb0343cf5b1c62f74a9752960873b5d',
     x86_64: '3805bdfd18ff5713bcd31a12f3c8b2a756093c6c30cce08c7b0e74249c97c546',
  })

  depends_on 'libffi'
  depends_on 'gettext'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
