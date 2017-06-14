require 'package'

class Cmatrix < Package
  description "CMatrix is a program to see the cool scrolling lines from 'The Matrix' movie."
  homepage 'http://www.asty.org/cmatrix/'
  version '1.2a'
  source_url 'http://www.asty.org/cmatrix/dist/cmatrix-1.2a.tar.gz'
  source_sha1 'ca078c10322a47e327f07a44c9a42b52eab5ad93'

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    system './configure --prefix=/usr/local CPPFLAGS="-I/usr/local/include/ncurses"'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
