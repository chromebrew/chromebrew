require 'package'

class Php7 < Package
  version '7.1.0'
  source_url 'http://php.net/distributions/php-7.1.0.tar.xz' # software source tarball url
  source_sha1 'c74c920256b9c6873bae696fbb0ec14a02dc8495'  # source tarball sha1 sum

  depends_on 'libxml2'

  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
