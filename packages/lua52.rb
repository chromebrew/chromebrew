require 'package'

class Lua52 < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.2.4'
  source_url 'https://www.lua.org/ftp/lua-5.2.4.tar.gz'
  source_sha256 'b9e2e4aad6789b3b63a056d442f7b39f0ecfca3ae0f1fc0ae4e9614401b69f4b'

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
    system "cat > #{CREW_DEST_PREFIX}/lib/pkgconfig/lua52.pc << \"EOF\"
V=5.2
R=5.2.4

prefix=#{CREW_PREFIX}
INSTALL_BIN=#{CREW_PREFIX}/bin
INSTALL_INC=#{CREW_PREFIX}/include
INSTALL_LIB=#{CREW_LIB_PREFIX}
INSTALL_MAN=#{CREW_PREFIX}/share/man/man1
INSTALL_LMOD=#{CREW_PREFIX}/share/lua/5.2
INSTALL_CMOD=#{CREW_PREFIX}/lib/lua/5.2
exec_prefix=#{CREW_PREFIX}
libdir=#{CREW_PREFIX}/lib
includedir=#{CREW_PREFIX}/include

Name: Lua
Description: An Extensible Extension Language
Version: 5.2.4
Requires:
Libs: -L#{CREW_LIB_PREFIX} -llua52 -lm -ldl
Cflags: -I#{CREW_PREFIX}/include
EOF
"
  end
end
