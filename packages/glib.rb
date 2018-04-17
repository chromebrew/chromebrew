require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.56.0'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.56/glib-2.56.0.tar.xz'
  source_sha256 'ecef6e17e97b8d9150d0e8a4b3edee1ac37331213b8a2a87a083deea408a0fc7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.56.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '422ea16181d61fe0b387291ed43c687309dedaa4e71eb940b0bff3ace1694156',
     armv7l: '422ea16181d61fe0b387291ed43c687309dedaa4e71eb940b0bff3ace1694156',
       i686: '14fc4856cf169052c5a16fced1e121d1e8ec6fd0aaece663d4a3bea35c9fcdf1',
     x86_64: '81f7387d0a0bda851dd8df7a09c8216f39f8813fd2824a134c4942a58f86fb84',
  })

  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
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
