require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.10'
  source_url 'https://namesdir.com/mirrors/nongnu/freetype/freetype-2.10.0.tar.gz'
  source_sha256 '955e17244e9b38adb0c98df66abb50467312e6bb70eac07e49ce6bd1a20e809a'

  binary_url ({
  })
  binary_sha256 ({
  })

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
