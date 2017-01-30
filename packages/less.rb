require 'package'

class Less < Package
  version '481'
  source_url 'ftp://ftp.gnu.org/gnu/less/less-481.tar.gz'
  source_sha1 '58e7e62a760a9ca3636349de8e3357f7102aea1d'

  depends_on 'buildessential'
  depends_on 'ncurses' 
  
  def self.build
    system "./configure"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end         
end
