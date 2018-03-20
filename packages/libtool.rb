require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface. https://www.gnu.org/software/libtool/'
  homepage 'http://ftp.igh.cnrs.fr/pub/gnu/libtool/'
  version '2.4.6'
  source_url 'http://ftp.igh.cnrs.fr/pub/gnu/libtool/libtool-2.4.6.tar.xz'
  source_sha256 '7c87a8c2c8c0fc9cd5019e402bed4292462d00a718a7cd5f11218153bf28b26f'

  depends_on 'm4'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
