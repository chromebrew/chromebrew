require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.5'
  source_url 'https://www.lua.org/ftp/lua-5.3.5.tar.gz'
  source_sha256 '0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4221d4178982208fe3fa4951a957b7ea49a5e9b4c2e36c1c659b5a7f3641d488',
     armv7l: '4221d4178982208fe3fa4951a957b7ea49a5e9b4c2e36c1c659b5a7f3641d488',
       i686: '1b400d13a757b4bfe4290587c7e6c3e9be386f5966efbe4e90f8cad44194154f',
     x86_64: '0c8aa3d1cda909e7f8a9f28c36acc459bdcae9091e300980fc6e7dcf2caf1313',
  })

  depends_on 'readline7'

  def self.build
    system "make -C src all PLAT=linux SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.check
    system "make", "test"
  end

  def self.install
    system 'make', 'linux', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "INSTALL_TOP=#{CREW_DEST_PREFIX}", 'install'
  end
end
