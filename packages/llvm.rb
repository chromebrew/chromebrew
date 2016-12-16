require 'package'

class Llvm < Package
  version '0.19.8'
  source_url 'http://ftp.gnu.org/pub/gnu/gettext/gettext-0.19.8.tar.xz'
  source_sha1 'dc551d4783edf691c1f0095ca927d3128b5093e8'

  depends_on 'buildessential'
  depends_on 'openssl_devel'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
