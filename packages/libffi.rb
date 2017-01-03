require 'package'

class Libffi < Package
  version '3.0.13-1'
  source_url 'ftp://sourceware.org/pub/libffi/libffi-3.0.13.tar.gz'
  source_sha1 'f5230890dc0be42fb5c58fbf793da253155de106'

  depends_on 'autoconf'
  depends_on 'automake'

  def self.build
    system "./configure", "--disable-debug", "--disable-dependency-tracking"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
