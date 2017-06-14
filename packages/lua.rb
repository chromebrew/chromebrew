require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.4'
  source_url 'https://www.lua.org/ftp/lua-5.3.4.tar.gz'
  source_sha1 '79790cfd40e09ba796b01a571d4d63b52b1cd950'

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.install
    system 'make', "INSTALL_TOP=#{CREW_DEST_DIR}/usr/local", 'install'
  end
end
