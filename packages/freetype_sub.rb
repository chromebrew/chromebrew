require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.10'
  source_url 'https://namesdir.com/mirrors/nongnu/freetype/freetype-2.10.0.tar.gz'
  source_sha256 '955e17244e9b38adb0c98df66abb50467312e6bb70eac07e49ce6bd1a20e809a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b2d3c0d50a433d0ffc1fbada114b76bc4147d2a67664155ac3d91342e501d557',
     armv7l: 'b2d3c0d50a433d0ffc1fbada114b76bc4147d2a67664155ac3d91342e501d557',
       i686: '9bd721ac92d77e19686c6e39f283a5d434b7649483b99ea01ae562c8d1b14e45',
     x86_64: 'b69cbd236ddc7ba3ee01719131832c174b345e12ea8df9ead43ebc1a8b622805',
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
