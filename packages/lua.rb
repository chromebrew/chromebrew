require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.4.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.3.tar.gz'
  source_sha256 'f8612276169e3bfcbcfb8f226195bfc6e466fe13042f1076cbde92b7ec96bbfb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.3_armv7l/lua-5.4.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.3_armv7l/lua-5.4.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.3_i686/lua-5.4.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.3_x86_64/lua-5.4.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '2cbf9670bd0a9388537d70d5559ff0505d31b6be36e85ccec0077ddb4f3fd3e3',
     armv7l: '2cbf9670bd0a9388537d70d5559ff0505d31b6be36e85ccec0077ddb4f3fd3e3',
       i686: '828d08293bb955aa2daa222fb6295a3c8f002c6ddd147d4d067129bed6b6e706',
     x86_64: 'a1e7d87857e5ea2be3988975750e4af3cb881643bd751beb316b19f9305f5b88'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} make PLAT=linux-readline"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            LIBDIR=#{CREW_LIB_PREFIX} \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            install"
  end
end
