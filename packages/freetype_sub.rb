require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.9'
  source_url 'http://download.savannah.gnu.org/releases/freetype/freetype-2.9.tar.gz'
  source_sha256 'bf380e4d7c4f3b5b1c1a7b2bf3abb967bda5e9ab480d0df656e0e08c5019c5e6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f180b27eb703e0e7680f53ee4396a7e9cfb4093d9f29b7d16fffad6c6476c912',
     armv7l: 'f180b27eb703e0e7680f53ee4396a7e9cfb4093d9f29b7d16fffad6c6476c912',
       i686: '71fb1bace0552659cfc86ef6ed88bbb1ce5c618061107381618f1a1060c47397',
     x86_64: '3ccd3b201456c5d9f2dac55311ed3f337edd230a894fae5e821072515a3d5d5f',
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
