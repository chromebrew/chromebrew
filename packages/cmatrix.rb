require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2a'
  source_url 'http://www.asty.org/cmatrix/dist/cmatrix-1.2a.tar.gz'
  source_sha256 '1fa6e6caea254b6fe70a492efddc1b40ad7ccb950a5adfd80df75b640577064c'

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system "CPPFLAGS=-I#{CREW_PREFIX}/include/ncurses ./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
