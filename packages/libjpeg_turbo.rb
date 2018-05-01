require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '1.5.3'
  source_url 'https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.5.3.tar.gz'
  source_sha256 'b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523'

  depends_on 'yasm' => :build

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-jpeg8",
           "--disable-static"
    system "make"
  end

  def self.check
    system "make -j#{CREW_NPROC} test"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
