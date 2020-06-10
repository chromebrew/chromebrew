require 'package'

class Libsoup < Package
  description 'libsoup is an HTTP client/server library for GNOME.'
  homepage 'https://wiki.gnome.org/Projects/libsoup'
  version '2.63.90'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libsoup/2.63/libsoup-2.63.90.tar.xz'
  source_sha256 '77b91be36717fb57144aa4222753fa7b7d81312439d59ac47486d675a3deae1a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.63.90-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.63.90-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.63.90-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsoup-2.63.90-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7cd95e9443e96306cd0e6d5f35f99b826261b6b8e74181db37b52aa9c70a876',
     armv7l: 'b7cd95e9443e96306cd0e6d5f35f99b826261b6b8e74181db37b52aa9c70a876',
       i686: '06ed2cb292334a1c49d43677901407b49bf7888eaf9534f3455d69c9d6bee231',
     x86_64: 'ff90e07fce6397d3ba711a615379f487266af5aa77359fa60fb193dff8da2dcb',
  })

  depends_on 'glib_networking'
  depends_on 'libpsl'
  depends_on 'sqlite'
  depends_on 'vala'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
