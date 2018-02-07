require 'package'

class Gtk3 < Package
  description 'Gtk3 is a cross-platform widget toolkit for creating graphical user interfaces.'
  homepage 'https://developer.gnome.org/gtk3/3.0/'
  version '3.22'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtk+/3.22/gtk+-3.22.26.tar.xz'
  source_sha256 '61eef0d320e541976e2dfe445729f12b5ade53050ee9de6184235cb60cd4b967'

  depends_on 'gdk_pixbuf'
  depends_on 'libepoxy'
  depends_on 'graphene'
  depends_on 'libxkbcommon'
  depends_on 'at_spi2_atk'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"  # for installation process
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
