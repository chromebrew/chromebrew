require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://hisham.hm/htop/'
  version '2.0.2'
  source_url 'http://hisham.hm/htop/releases/2.0.2/htop-2.0.2.tar.gz'
  source_sha1 '201f793f13dce2448e36047079875b9bd5bba75a'

  depends_on 'buildessential'
  depends_on 'ncurses'
  
  def self.build
    system "./configure --disable-unicode"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
