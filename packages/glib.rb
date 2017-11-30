require 'package'

class Glib < Package
  description 'GLib provides the core application building blocks for libraries and applications written in C.'
  homepage 'https://developer.gnome.org/glib'
  version '2.52.3'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/glib/2.52/glib-2.52.3.tar.xz'
  source_sha256 '25ee7635a7c0fcd4ec91cbc3ae07c7f8f5ce621d8183511f414ded09e7e4e128'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.52.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.52.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.52.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glib-2.52.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8de64a3352a3c281603ed7127762f1eb24e7d04def0d0fa2f7953fb45743543',
     armv7l: 'd8de64a3352a3c281603ed7127762f1eb24e7d04def0d0fa2f7953fb45743543',
       i686: '4040a38f799bb98a4df04347dfd94b9a4a54fa72a45a034aac5f9165c7cbbf09',
     x86_64: '8dd2f3eb465d91ad6db0a9f2443a430470c3afe76690b7d6ca35645232806b46',
  })

  depends_on 'libffi'
  depends_on 'gettext'
  depends_on 'util_linux'
  depends_on 'zlibpkg'
  depends_on 'python27'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --with-pcre"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
