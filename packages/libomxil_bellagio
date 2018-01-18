require 'package'

class Libomxil_bellagio < Package
  description 'Bellagio is an opensource implementation of the Khronos OpenMAX Integration Layer API to access multimedia components.'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '0.9.3'
  source_url 'https://sourceforge.net/projects/omxil/files/omxil/Bellagio%200.9.3/libomxil-bellagio-0.9.3.tar.gz'
  source_sha256 '593c0729c8ef8c1467b3bfefcf355ec19a46dd92e31bfc280e17d96b0934d74c'

  def self.build
    system "./configure","--prefix=#{CREW_PREFIX}","--libdir=#{CREW_LIB_PREFIX}"
    system "make", "-j1 CFLAGS=-Wno-error=switch"    # only -j1 possible (tested on armv7l)
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
