require 'package'

class Libtool < Package
  description 'GNU libtool is a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface.'
  homepage 'https://www.gnu.org/software/libtool/'
  version '2.4.6-2'
  source_url 'https://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.gz'
  source_sha256 'e3bd4d5d3d025a36c21dd6af7ea818a2afcd4dfc1ea5a17b39d7854bcd0c06e3'

  depends_on 'buildessential'
  depends_on 'm4'

  def self.build
    system "./configure", "--disable-static", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
