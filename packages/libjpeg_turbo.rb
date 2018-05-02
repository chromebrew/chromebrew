require 'package'

class Libjpeg_turbo < Package
  description 'Libjpeg-turbo implements both the traditional libjpeg API as well as the less powerful but more straightforward TurboJPEG API.'
  homepage 'https://libjpeg-turbo.org'
  version '1.5.3'
  source_url 'https://downloads.sourceforge.net/libjpeg-turbo/libjpeg-turbo-1.5.3.tar.gz'
  source_sha256 'b24890e2bb46e12e72a79f7e965f409f4e16466d00e1dd15d93d73ee6b592523'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew2/chromebrew2/libjpeg_turbo-1.5.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew2/chromebrew2/libjpeg_turbo-1.5.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew2/chromebrew2/libjpeg_turbo-1.5.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew2/chromebrew2/libjpeg_turbo-1.5.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '37833441c3763bdf916115da6d41bb70d23e139048eb2765498552dde0dde4f1',
     armv7l: '37833441c3763bdf916115da6d41bb70d23e139048eb2765498552dde0dde4f1',
       i686: '596890fe0a321224e72922469b029d2518fa6729978f9991f6b2630a9329b545',
     x86_64: 'a237e9655dd86d31cb544461c03dbf168923cb17b9958df7af61eec9ebe25515',
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
