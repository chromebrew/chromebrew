require 'package'

class Jansson < Package
  description 'Jansson is a C library for encoding, decoding and manipulating JSON data.'
  homepage 'http://www.digip.org/jansson/'
  version '2.10'
  source_url 'https://github.com/akheron/jansson/archive/v2.10.tar.gz'
  source_sha256 'b0a899f90ade82e42da0ecabc8af1fa296d69691e7c0786c4994fb79d4833ebb'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'cmake' => :build

  def self.build
    system "cmake . -DPREFIX=#{CREW_PREFIX} -DCMAKE_INSTALL_LIBDIR=#{CREW_DEST_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
