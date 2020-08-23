require 'package'

class Lxappearance < Package
  description 'LXDE Theme Switcher'
  homepage 'http://lxde.org/'
  version '0.6.3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/sourceforge/lxde/lxappearance-0.6.3.tar.xz'
  source_sha256 '7222d858b8fef4b7967c42142d61e82ded6dd42dc5ef1d59caad775795928b38'

  depends_on 'gtk3'
  depends_on 'desktop_file_utilities'
  depends_on 'dbus_glib'
  
  def self.build
      system "./configure #{CREW_OPTIONS} --enable-gtk3 --enable-dbus"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end