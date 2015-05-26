require 'package'

class Pkgconfig < Package
  version '0.28'
  source_url 'http://pkgconfig.freedesktop.org/releases/pkg-config-0.28.tar.gz' # software source tarball url  
  source_sha1 '71853779b12f958777bffcb8ca6d849b4d3bed46'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure --with-internal-glib"
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
