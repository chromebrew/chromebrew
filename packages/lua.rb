require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.4'
  source_url 'https://www.lua.org/ftp/lua-5.3.4.tar.gz'
  source_sha256 'f681aa518233bc407e23acf0f5887c884f17436f000d453b2491a9f11a52400c'

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.install
    system 'make', "INSTALL_TOP=#{CREW_DEST_DIR}/usr/local", 'install'
  end
end
