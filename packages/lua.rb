require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.4'
  source_url 'https://www.lua.org/ftp/lua-5.3.4.tar.gz'
  source_sha256 'f681aa518233bc407e23acf0f5887c884f17436f000d453b2491a9f11a52400c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '855cb5cc640a9d39fd8ed2a918c78fb2056fce8d6b57c824f45690e959215498',
     armv7l: '855cb5cc640a9d39fd8ed2a918c78fb2056fce8d6b57c824f45690e959215498',
       i686: '0d840bfc5844427ce211a6eca018d3ba92984ff24e917a711fd2d6b7c4727a1c',
     x86_64: '5dfd73751b240880ccaaedb1207468277704a2ec819dd74e2a137755263d7e05',
  })

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.install
    system 'make', "INSTALL_TOP=#{CREW_DEST_DIR}/usr/local", 'install'
  end
end
