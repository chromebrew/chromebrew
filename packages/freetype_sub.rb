require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.9'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz'
  source_sha256 'bf380e4d7c4f3b5b1c1a7b2bf3abb967bda5e9ab480d0df656e0e08c5019c5e6'


  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  
  def self.build
      system "./configure \
              CFLAGS=\" -fPIC\" \
              --prefix=#{CREW_PREFIX} \
              --libdir=#{CREW_LIB_PREFIX} \
              --without-harfbuzz"
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar |xargs rm -rf"  # make sure to delete downloaded files
  end
  
end
