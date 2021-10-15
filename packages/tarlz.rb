require 'package'

class Tarlz < Package
  description 'Tarlz is a massively parallel (multi-threaded) combined implementation of the tar archiver and the lzip compressor.'
  homepage 'https://www.nongnu.org/lzip/lzip.html'
  version '1.21'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/tarlz/tarlz-0.21.tar.lz'
  source_sha256 '0f972112dd3f126a394d5a04107695ccbbb9e603e7b193367bd1714607e0adf4'

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
