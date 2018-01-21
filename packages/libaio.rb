require 'package'

class Libaio < Package
  description 'Linux-native asynchronous I/O access library'
  homepage 'https://pagure.io/libaio'
  version '0.3.110-2'
  source_url 'http://libaio.sourcearchive.com/downloads/0.3.110-2/libaio_0.3.110.orig.tar.gz'
  source_sha256 'e019028e631725729376250e32b473012f7cb68e1f7275bfc1bbcdd0f8745f7e'

  def self.build
    system "sed -i 's,prefix=/usr,prefix=#{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,libdir=\$(prefix)/lib,libdir=#{CREW_DEST_LIB_PREFIX},' Makefile"
    system "make"
  end

  def self.install
    system "make install"
  end
end
