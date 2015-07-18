require 'package'

class Freetype < Package
  version '2.6'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.6.tar.gz'
  source_sha1 '12dd3267af62cccc32045ed99984f3d8a8ddbf90'

  def self.build
      system "./configure --libdir=/usr/local/lib64/ CC=\"gcc -m64\" CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
