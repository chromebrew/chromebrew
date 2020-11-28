require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.67.0'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/glib/2.67/glib-2.67.0.tar.xz'
  source_sha256 '0b15e57ab6c2bb90ced4e24a1b0d8d6e9a13af8a70266751aa3a45baffeed7c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.67.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0d66968376ed154064cda24cc3df68bf8e54f1f6f5cdbd05fc7389b4847ec119',
     armv7l: '0d66968376ed154064cda24cc3df68bf8e54f1f6f5cdbd05fc7389b4847ec119',
       i686: 'f5c028746bb4e0cc54e1cda5c0b1226f7ac663d21924fc2cd259c0047b2395e1',
     x86_64: '5a825a37542e1a8ebeb53eaefb321345a164dd822156b92602befc399ce9cce0',
  })

  depends_on 'pcre2'
  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'shared_mime_info'
  depends_on 'util_linux'
  depends_on 'six'
  
  ENV['CFLAGS'] = "-fno-stack-protector"
  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
    -Dselinux=disabled \
    -Dsysprof=disabled \
    -Dman=false \
    -Dgtk_doc=false \
    -Diconv=external \
    -Dinternal_pcre=true \
    build"
    system "meson configure build"
    system "ninja -C build"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
  end
end
