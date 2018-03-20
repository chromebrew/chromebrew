require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces. https://developer.gnome.org/gtk3/3.0/'
  homepage 'https://download.gnome.org/sources/gtk+/'
  version '3.22.29'
  source_url 'https://download.gnome.org/sources/gtk+/3.22/gtk+-3.22.29.tar.xz'
  source_sha256 'a07d64b939fcc034a066b7723fdf9b24e92c9cfb6a8497593f3471fe56fbbbf8'

  depends_on 'gdk_pixbuf'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  
  def self.build
    system "sh autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end