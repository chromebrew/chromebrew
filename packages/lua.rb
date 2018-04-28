require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.4-1'
  source_url 'https://www.lua.org/ftp/lua-5.3.4.tar.gz'
  source_sha256 'f681aa518233bc407e23acf0f5887c884f17436f000d453b2491a9f11a52400c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.4-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6f4e3cc1634a552c4260a0193aa97b83fc86da62a2414c7cc3f0e68f641a066',
     armv7l: 'b6f4e3cc1634a552c4260a0193aa97b83fc86da62a2414c7cc3f0e68f641a066',
       i686: 'e2c847912ac13d1bb7392c37d5a57a3540418d62ec25e5c4b939899b2ca9aea4',
     x86_64: '92bd9b21a28c907827fd017a6097009ac8fd7c1c85e749bdbf7b36021a2a3ccd',
  })

  depends_on 'readline'

  def self.build
    system "make -C src all SYSCFLAGS=\"-DLUA_USE_LINUX\" SYSLIBS=\"-Wl,-E -ldl -lreadline -lncurses\""
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=#{CREW_LIB_PREFIX}",
           "INSTALL_TOP=#{CREW_DEST_PREFIX}", 'install'
  end
end
