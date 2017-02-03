require 'package'

class Libffi < Package
  version '3.2.1'
  source_url 'ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz'
  source_sha1 '280c265b789e041c02e5c97815793dfc283fb1e6'

  depends_on 'autoconf'
  depends_on 'automake'

  def self.build
    system "./configure", "--disable-debug", "--disable-dependency-tracking"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
