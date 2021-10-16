require 'package'

class Clzip < Package
  description 'Clzip is a drop-in implementation of lzip written in C.'
  homepage 'https://www.nongnu.org/lzip/clzip.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/clzip/clzip-1.12.tar.gz'
  source_sha256 'fcc92b3006d87b7c4affa03fe9dcc4869a802253052653200c26f6ba718bfee8'

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
