require 'package'

class Lua51 < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.1.5'
  source_url 'https://www.lua.org/ftp/lua-5.1.5.tar.gz'
  source_sha256 '2640fc56a795f29d28ef15e13c34a47e223960b0240e8cb0a82d9b0738695333'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make -C src all PLAT=linux SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.check
    system 'make', 'test'
  end

  def self.install
    system 'make', 'linux', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "INSTALL_TOP=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pkgconfig"
    system "cat > #{CREW_DEST_PREFIX}/lib/pkgconfig/lua51.pc << \"EOF\"
V=5.1
R=5.1.5

prefix=#{CREW_PREFIX}
INSTALL_BIN=#{CREW_PREFIX}/bin
INSTALL_INC=#{CREW_PREFIX}/include
INSTALL_LIB=#{CREW_LIB_PREFIX}
INSTALL_MAN=#{CREW_PREFIX}/share/man/man1
INSTALL_LMOD=#{CREW_PREFIX}/share/lua/5.1
INSTALL_CMOD=#{CREW_PREFIX}/lib/lua/5.1
exec_prefix=#{CREW_PREFIX}
libdir=#{CREW_PREFIX}/lib
includedir=#{CREW_PREFIX}/include

Name: Lua
Description: An Extensible Extension Language
Version: 5.1.5
Requires:
Libs: -L#{CREW_LIB_PREFIX} -llua51 -lm -ldl
Cflags: -I#{CREW_PREFIX}/include
EOF
"
  end
end
