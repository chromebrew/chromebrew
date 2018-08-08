require 'package'

class Libgconf < Package
  description 'GConf is a system for storing application preferences.'
  homepage 'https://projects-old.gnome.org/gconf/'
  version '3.2.6'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/GConf/3.2/GConf-3.2.6.tar.xz'
  source_sha256 '1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'dbus_glib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-orbit"
    system "make"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
