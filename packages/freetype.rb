require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.7.1'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.7.1.tar.gz'
  source_sha1 '60fb8097901a887b8e8f6e7f777ef0516ae68022'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
