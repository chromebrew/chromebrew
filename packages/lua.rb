require 'package'

class Lua < Package
  description 'Lua is a powerful, efficient, lightweight, embeddable scripting language.'
  homepage 'https://www.lua.org/'
  version '5.4.2'
  compatibility 'all'
  source_url 'https://www.lua.org/ftp/lua-5.4.2.tar.gz'
  source_sha256 '11570d97e9d7303c0a59567ed1ac7c648340cd0db10d5fd594c09223ef2f524f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/lua-5.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d9a0982da7b59fa17892c699f2818ee137a1eaba895da3519c67e71b4aabd6d',
     armv7l: '1d9a0982da7b59fa17892c699f2818ee137a1eaba895da3519c67e71b4aabd6d',
       i686: '8c04a985efa92609659cb618efd59086c7b57ae7ca3f101ebb6bf68d13a127a9',
     x86_64: 'a063effc0721cc63a4872338a6d139e2f5b8611e1eb3b9391c111444279d88f0',
  })

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
