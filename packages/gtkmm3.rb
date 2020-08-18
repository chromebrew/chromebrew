require 'package'

class Gtkmm3 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.24.1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.24/gtkmm-3.24.1.tar.xz'
  source_sha256 'ddfe42ed2458a20a34de252854bcf4b52d3f0c671c045f56b42aa27c7542d2fd'

  depends_on 'atkmm'
  depends_on 'gtk3'
  depends_on 'pangomm'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
