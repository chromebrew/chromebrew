require 'package'

class Plzip < Package
  description 'Plzip is a massively parallel (multi-threaded) drop-in implementation of lzip.'
  homepage 'https://www.nongnu.org/lzip/plzip.html'
  version '1.9'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.9.tar.gz'
  source_sha256 '14d8d1db8dde76bdd9060b59d50b2943417eb4c0fbd2b84736546b78fab5f1a7'

  depends_on 'lzlib' => :build

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
