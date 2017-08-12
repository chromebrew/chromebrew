require 'package'

class Libxslt < Package
  description 'Libxslt is the XSLT C library developed for the GNOME project.'
  homepage 'http://xmlsoft.org/libxslt/'
  version '1.1.28-2'
  source_url 'http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz'
  source_sha256 '5fc7151a57b89c03d7b825df5a0fae0a8d5f05674c0e7cf2937ecec4d54a028c'

  depends_on 'libxml2'

  def self.build
    system "./configure", "--without-python", "--disable-static", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
