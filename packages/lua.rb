require 'package'
 
class Lua < Package
  version '5.3.1'
  source_url 'http://www.lua.org/ftp/lua-5.3.1.tar.gz'
  source_sha1 '1676c6a041d90b6982db8cef1e5fb26000ab6dee'
  
  depends_on 'readline'
  depends_on 'ncurses'
  
  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""                                                 # ordered chronologically
  end
  
  def self.install
    system "make", "INSTALL_TOP=#{CREW_DEST_DIR}/usr/local", "install"
  end
end
