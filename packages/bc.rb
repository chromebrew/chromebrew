require 'package'

class Bc < Package
  version '1.06'
  source_url 'http://ftp.gnu.org/gnu/bc/bc-1.06.tar.gz'
  source_sha1 'c8f258a7355b40a485007c40865480349c157292'

  depends_on 'flex'

  def self.build
    system "./configure --libdir=/usr/local/lib#{SHORTARCH}/"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
