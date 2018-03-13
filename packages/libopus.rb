require 'package'

class Libopus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'http://opus-codec.org/'
  version '1.2'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.2.tar.gz'
  source_sha256 '77db45a87b51578fbc49555ef1b10926179861d854eb2613207dc79d9ec0a9a9'



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
