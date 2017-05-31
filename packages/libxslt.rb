require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.28-1'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz'
  source_sha1 '4df177de629b2653db322bfb891afa3c0d1fa221'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
