require 'package'

class Lzlib < Package
  description 'Lzlib is a data compression library providing in-memory LZMA compression and decompression functions.'
  homepage 'https://www.nongnu.org/lzip/lzlib.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.12.tar.lz'
  source_sha256 '238469af158a5a52e480907014dd90fe8ae5a78070473e18634fb74ac17cfcd8'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            CC=#{CREW_TGT}-gcc \
            CFLAGS='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
