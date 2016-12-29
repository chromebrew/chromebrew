require 'package'

class Php7 < Package
  version '7.0.14'
  source_url 'http://php.net/get/php-7.0.14.tar.gz/from/this/mirror' # software source tarball url
  source_sha1 '7d098167c63446011e87b1d1578f2f3ac0bab01a'  # source tarball sha1 sum
  
  depends_on 'nginx'
  depends_on 'libxml2'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
