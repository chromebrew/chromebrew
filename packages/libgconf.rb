require 'package'

class Libgconf < Package
  description 'GConf is a system for storing application preferences.'
  homepage 'https://projects-old.gnome.org/gconf/'
  version '3.2.6'
  license 'LGPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/GConf/3.2/GConf-3.2.6.tar.xz'
  source_sha256 '1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
     armv7l: 'a6c6861a58365e66df3a2eb01faa1f801d52a34fbb10b2f1ac842f7e72affb6c',
     x86_64: 'be97ae6807ad929e22b58e5ce3b561d0b0b49532b9980024aa854ffd762a1ec5'
  })

  depends_on 'dbus' # R
  depends_on 'dbus_glib' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-orbit"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
