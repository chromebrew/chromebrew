require 'package'

class Lua53 < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.5-2'
  source_url 'https://www.lua.org/ftp/lua-5.3.5.tar.gz'
  source_sha256 '0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system 'sed "s/^R= \$V.4/R= \$V.5/" -i Makefile' # Makefile has the wrong version number
    system "make -C src all PLAT=linux SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.check
    system 'make', 'test'
  end

  def self.install
    system 'make', 'linux', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "INSTALL_TOP=#{CREW_DEST_PREFIX}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/lib/pkgconfig"
    system "cat > #{CREW_DEST_PREFIX}/lib/pkgconfig/lua53.pc << \"EOF\"
V=5.3
R=5.3.5

prefix=#{CREW_PREFIX}
INSTALL_BIN=#{CREW_PREFIX}/bin
INSTALL_INC=#{CREW_PREFIX}/include
INSTALL_LIB=#{CREW_LIB_PREFIX}
INSTALL_MAN=#{CREW_PREFIX}/share/man/man1
INSTALL_LMOD=#{CREW_PREFIX}/share/lua/5.3
INSTALL_CMOD=#{CREW_PREFIX}/lib/lua/5.3
exec_prefix=#{CREW_PREFIX}
libdir=#{CREW_PREFIX}/lib
includedir=#{CREW_PREFIX}/include

Name: Lua
Description: An Extensible Extension Language
Version: 5.3.5 
Requires:
Libs: -L#{CREW_LIB_PREFIX} -llua53 -lm -ldl
Cflags: -I#{CREW_PREFIX}/include
EOF
"
  end
end
