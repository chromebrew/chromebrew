require 'package'

class Libgconf < Package
  description 'GConf is a system for storing application preferences.'
  homepage 'https://projects-old.gnome.org/gconf/'
  version '3.2.6'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/GConf/3.2/GConf-3.2.6.tar.xz'
  source_sha256 '1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libgconf-3.2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
     armv7l: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
       i686: '87bff50ea19f42f0fa87a61e7b7fbed10b5f8e2305659e0d90cf26b868f9e8a4',
     x86_64: 'be97ae6807ad929e22b58e5ce3b561d0b0b49532b9980024aa854ffd762a1ec5',
  })

  depends_on 'dbus_glib'
  depends_on 'gtk3'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-orbit"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
