require 'package'

class Lziprecover < Package
  description 'Lziprecover is a data recovery tool and decompressor for files in the lzip compressed data format'
  homepage 'https://www.nongnu.org/lzip/lziprecover.html'
  version '1.22'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lziprecover/lziprecover-1.22.tar.lz'
  source_sha256 'cbce50ab328d3965231b0e7298ceb4d479f92ebdc362da265a83be2e87a961f7'

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
