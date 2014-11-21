require 'package'

class Less < Package
  version '451'
  source_url 'ftp://ftp.gnu.org/gnu/less/less-451.tar.gz'
  source_sha1 'ee95be670e8fcc97ac87d02dd1980209130423d0'

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
