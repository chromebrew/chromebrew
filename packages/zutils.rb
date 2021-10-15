require 'package'

class Zutils < Package
  description 'Zutils is a collection of utilities able to process any combination of compressed and uncompressed files transparently.'
  homepage 'https://www.nongnu.org/zutils/zutils.html'
  version '1.10'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/zutils/zutils-1.10.tar.lz'
  source_sha256 '0dd44138292d5757648037195b6945c3df70b316221b4285520ad38f2eaeb195'

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
