require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.4.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.6.tar.gz'
  source_sha256 '7d5ea1b9cb6aa0b59ca3dde1c6adcb57ef83a1ba8e5432c0ecd06bf439b3ad88'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6_armv7l/lua-5.4.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6_armv7l/lua-5.4.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6_i686/lua-5.4.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.6_x86_64/lua-5.4.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fc4340ee3ff68dbe3d681dfcf231c71e2ac6acfd1203c1708ce55c24e5233d1b',
     armv7l: 'fc4340ee3ff68dbe3d681dfcf231c71e2ac6acfd1203c1708ce55c24e5233d1b',
       i686: '90d303add8929cbf93d3af19d321d3ce553ebc4304475565162e3fa1f7d41cee',
     x86_64: '87f5cfdf7e03bc4997a2a36457a1fa269d308194d1351afde5b9e4a0c99c7ea4'
  })

  def self.build
    system 'make PLAT=linux-readline'
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            INSTALL_LIB=#{CREW_DEST_LIB_PREFIX} \
            INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            install"
  end
end
