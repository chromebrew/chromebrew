require 'package'

class Pcre < Package
  version '8.39'
  source_url 'http://downloads.sourceforge.net/pcre/pcre-8.39.tar.bz2' # software source tarball url
  source_sha1 '5e38289fd1b4ef3e8426f31a01e34b6924d80b90'                  # source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
