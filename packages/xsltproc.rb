require 'package'

class Xsltproc < Package
  description 'The XSLT C library for GNOME'
  homepage 'http://xmlsoft.org/XSLT/xsltproc2.html'
  version '0.52'
  source_url 'https://git.gnome.org/browse/libxslt/snapshot/libxslt-1.1.33-rc1.tar.xz'
  source_sha256 '5e257266ba8472c5c319aff87d54140edb950972805cbf5bcf45c4a040c16506'

  def self.build
    system "./autogen.sh", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
