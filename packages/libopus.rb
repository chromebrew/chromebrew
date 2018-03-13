require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.2.1'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.2.1.tar.gz'
  source_sha256 'cfafd339ccd9c5ef8d6ab15d7e1a412c054bf4cb4ecbbbcc78c12ef2def70732'



  def self.build
    system "./configure  \
	    --prefix=#{CREW_PREFIX} \
	    --libdir=#{CREW_LIB_PREFIX} \
            --enable-shared \
            --enable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
