require 'package'

class Zutils < Package
  description 'Zutils is a collection of utilities able to process any combination of compressed and uncompressed files transparently.'
  homepage 'https://www.nongnu.org/zutils/zutils.html'
  version '1.10'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/zutils/zutils-1.10.tar.lz'
  source_sha256 '0dd44138292d5757648037195b6945c3df70b316221b4285520ad38f2eaeb195'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zutils/1.10_armv7l/zutils-1.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zutils/1.10_armv7l/zutils-1.10-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zutils/1.10_i686/zutils-1.10-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zutils/1.10_x86_64/zutils-1.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '85d349dc0b674391b805d0a9f08b92d1856d8261b28f5f8f0d17775445317094',
     armv7l: '85d349dc0b674391b805d0a9f08b92d1856d8261b28f5f8f0d17775445317094',
       i686: 'b896cdd1bfa6bde2e69a55159f0069306622d3f19b237216b254f2d83d84e0bb',
     x86_64: '041abd594e9a9d06f2208b45697acdf7695232bfd9d6b47906989c22ff097657',
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
