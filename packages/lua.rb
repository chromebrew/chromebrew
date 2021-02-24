require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.4.2'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.2.tar.gz'
  source_sha256 '11570d97e9d7303c0a59567ed1ac7c648340cd0db10d5fd594c09223ef2f524f'

  def self.build
    system "make PLAT=linux-readline"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            LIBDIR=#{CREW_LIB_PREFIX} \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            install"
  end
end
