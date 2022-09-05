require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.4.4'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.4.tar.gz'
  source_sha256 '164c7849653b80ae67bec4b7473b884bf5cc8d2dca05653475ec2ed27b9ebf61'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.4_armv7l/lua-5.4.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.4_armv7l/lua-5.4.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.4_i686/lua-5.4.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lua/5.4.4_x86_64/lua-5.4.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dbf346d9ed69edd4e33914a98eae83badbdf2c6c3470b24118844d76154426bf',
     armv7l: 'dbf346d9ed69edd4e33914a98eae83badbdf2c6c3470b24118844d76154426bf',
       i686: 'a45a506c23fc52d59a6e888dddaffa9089668d080cc5d274963ecd634db3aa09',
     x86_64: '88a629ca4d1efb18452ff8481bb1113e6d53115a713faebc508586a1f6f09b59'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} make PLAT=linux-readline"
  end

  def self.install
    system "make PREFIX=#{CREW_PREFIX} \
            INSTALL_LIB=#{CREW_DEST_LIB_PREFIX} \
            INSTALL_MAN=#{CREW_DEST_MAN_PREFIX}/man1 \
            INSTALL_TOP=#{CREW_DEST_PREFIX} \
            install"
  end
end
