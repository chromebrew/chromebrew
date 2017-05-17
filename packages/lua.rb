require 'package'
 
class Lua < Package
  version '5.3.3'
  source_url 'https://www.lua.org/ftp/lua-5.3.3.tar.gz'
  source_sha1 'a0341bc3d1415b814cc738b2ec01ae56045d64ef'
  
  depends_on 'readline'
  depends_on 'ncurses'
  
  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""                                                 # ordered chronologically
  end
  
  def self.install
    system "make", "INSTALL_TOP=#{CREW_DEST_DIR}/usr/local", "install"
  end
end
