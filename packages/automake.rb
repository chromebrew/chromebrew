require 'package'

class Automake < Package
  version '1.14'
  source_url 'ftp://ftp.gnu.org/gnu/automake/automake-1.14.tar.xz'
  source_sha1 '793881a445134b7561637d6f2a3ca611276e39fe'

  depends_on 'autoconf'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
