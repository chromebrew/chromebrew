require 'package'

class Lua < Package
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
    system 'make',
      '-C', 'src',
      'all',
      'PLAT=linux',
      'SYSCFLAGS=-DLUA_USE_LINUX -fPIC',
      'SYSLIBS=-Wl,-E -ldl -lreadline -lncurses -fPIC'
  end

  def self.check
    system "make", "test"
  end

  def self.install
    system 'make', 
      'linux', 
      "PREFIX=#{CREW_PREFIX}",
      "LIBDIR=#{CREW_LIB_PREFIX}",
      "INSTALL_TOP=#{CREW_DEST_PREFIX}", 
      'install'
  end
end
