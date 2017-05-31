require 'package'

class Inetutils < Package
  description 'Inetutils - GNU network utilities is a collection of common network programs.'
  homepage 'https://www.gnu.org/software/inetutils/'
  version '1.9.4'
  source_url 'http://ftp.gnu.org/gnu/inetutils/inetutils-1.9.4.tar.gz' # Software source tarball url  
  source_sha1 'defae98a27c0e9516c4ef2321a374a3645adb3b9'

  depends_on 'buildessential'
  
  def self.build                                                  # self.build contains commands needed to build the software from source
    system "./configure" 
    system "make"                                                 # ordered chronologically
  end
  
  def self.install                                                # self.install contains commands needed to install the software on the target system
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"          # remember to include DESTDIR set to CREW_DEST_DIR - needed to keep track of changes made to system
  end         
end
