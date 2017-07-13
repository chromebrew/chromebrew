require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.7.1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.gz'
  source_sha256 '162ef25aa64480b1189cdb261228e6c5c44f212aac4b4621e28cf2157efb59f5'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
