require 'package'

class Pcre < Package
  version '8.39'
  source_url 'http://downloads.sourceforge.net/pcre/pcre-8.39.tar.bz2' # software source tarball url
  source_sha1 'b3aec1f643d9701841e2f9d57ac121a7ff448fc8'                  # source tarball sha1 sum
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure"
    system "make"                                                 # ordered chronologically
  end

  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end
end
