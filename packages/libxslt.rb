require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.29'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.29.tar.gz'
  source_sha256 'b5976e3857837e7617b29f2249ebb5eeac34e249208d31f1fbf7a6ba7a4090ce'

  depends_on 'libxml2'

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
