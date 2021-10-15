require 'package'

class Lunzip < Package
  description 'Lunzip is a decompressor for lzip files.'
  homepage 'https://www.nongnu.org/lzip/lunzip.html'
  version '1.12'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/lzip/lunzip/lunzip-1.12.tar.gz'
  source_sha256 'e55b4aaac5666b6ccad8459e52f8adb6869ce259f686e960129ae1e1bdf52ad2'

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
