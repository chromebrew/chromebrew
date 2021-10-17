require 'package'

class Lziprecover < Package
  description 'Lziprecover is a data recovery tool and decompressor for files in the lzip compressed data format'
  homepage 'https://www.nongnu.org/lzip/lziprecover.html'
  version '1.22'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lziprecover/lziprecover-1.22.tar.lz'
  source_sha256 'cbce50ab328d3965231b0e7298ceb4d479f92ebdc362da265a83be2e87a961f7'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lziprecover/1.22_armv7l/lziprecover-1.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lziprecover/1.22_armv7l/lziprecover-1.22-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lziprecover/1.22_i686/lziprecover-1.22-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lziprecover/1.22_x86_64/lziprecover-1.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6b3760cc1668b84b4f8bef254c53172b8f642dd8bf6e15a38df6dda7d1c643f7',
     armv7l: '6b3760cc1668b84b4f8bef254c53172b8f642dd8bf6e15a38df6dda7d1c643f7',
       i686: 'd7c03262eab9cac3b9dad80b6e7b3a3e962e28e271184c83fdb5941ad959156f',
     x86_64: '9de062c2ed5dc0eb7a328bb8b420860f38a9321ccd9f59e8239faa75de5ee203',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              CXX=#{CREW_TGT}-g++ \
              CXXFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
