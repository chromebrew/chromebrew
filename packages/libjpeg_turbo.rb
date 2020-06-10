require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '1.5.3'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.5.3.tar.gz'
  source_sha256 'b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-1.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-1.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-1.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libjpeg_turbo-1.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '63223b719a8f80150f0412ffac9f05ddf23819d0d7279a951fb18b3205f23f3f',
     armv7l: '63223b719a8f80150f0412ffac9f05ddf23819d0d7279a951fb18b3205f23f3f',
       i686: 'e2b33c627117572ecf3b71abda12b52a45cf757b183998adf9a74d65eff18356',
     x86_64: '908cafa1cf0837495cb52af3725584a5a735bffa6f66b13459b1749679767305',
  })

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
