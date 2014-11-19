require 'package'

class M4 < Package
  version '1.4.17'
  source_url 'ftp://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz'
  source_sha1 '74ad71fa100ec8c13bc715082757eb9ab1e4bbb0'

  depends_on 'libsigsegv'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
