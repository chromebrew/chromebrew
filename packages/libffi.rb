require 'package'

class Libffi < Package
  version '3.2.1-1'
  source_url 'ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz'
  source_sha1 '280c265b789e041c02e5c97815793dfc283fb1e6'

  def self.build
    system "./configure", "--enable-shared", "--disable-static", "--with-pic", "--disable-debug", "--disable-dependency-tracking"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    # system "make check"         # DejaGNU required
  end
end
