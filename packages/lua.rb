require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.5-2'
  source_url 'https://www.lua.org/ftp/lua-5.3.5.tar.gz'
  source_sha256 '0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8d7f0f8bdf7a45b010fb1c86d22a00180795705143a9572d1a86d9ceacc49a28',
     armv7l: '8d7f0f8bdf7a45b010fb1c86d22a00180795705143a9572d1a86d9ceacc49a28',
       i686: '29e15f8cfe77bb937f8717b90b3c6dc69097ea0d6d1685d0eb1987b9c3e5d7c0',
     x86_64: '999525e2de56e7cdcd1b56c930acd74d3e4e20cc4a23d5936e468afd03aca118',
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
