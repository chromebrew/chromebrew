require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.3.5-1'
  source_url 'https://www.lua.org/ftp/lua-5.3.5.tar.gz'
  source_sha256 '0c2eed3f960446e1a3e4b9a1ca2f3ff893b6ce41942cf54d5dd59ab4b3b058ac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.3.5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e7637922564311eddb467373ce87a1220399ee38ada304d5e66555835959e9da',
     armv7l: 'e7637922564311eddb467373ce87a1220399ee38ada304d5e66555835959e9da',
       i686: '7062884ea29cc4b87620ce1cb4228f81cd1427684378f50e4b539aae030d95ca',
     x86_64: '43b7e0de02fa42251c7881884c48b6593c9c78387356e1b2ea346a4487838671',
  })

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
