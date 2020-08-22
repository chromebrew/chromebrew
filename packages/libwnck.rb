require 'package'

class Libwnck < Package
  description 'Library for layout and rendering of text'
  homepage 'http://www.gnome.org/'
  version '3.32.0'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/libwnck/3.32/libwnck-3.32.0.tar.xz'
  source_sha256 '9595835cf28d0fc6af5526a18f77f2fcf3ca8c09e36741bb33915b6e69b8e3ca'

  depends_on 'startup_notification'
  depends_on 'pygtk'
  depends_on 'libxres'

  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end
  
  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end