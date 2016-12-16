require 'package'

class Less < Package
  version '451'
  source_url 'ftp://ftp.gnu.org/gnu/less/less-451.tar.gz'
  source_sha1 'ee95be670e8fcc97ac87d02dd1980209130423d0'
  binary_url({
    armv7l: "https://dl.dropboxusercontent.com/s/tsyva5iweqp2blq/less-451-chromeos-armv7l.tar.xz",
  })
  binary_sha1({
    armv7l: "c36725933672985b649073b0a6345e68c6bea96d",
  })

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
