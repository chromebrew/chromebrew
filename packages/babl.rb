require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.56'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.56.tar.bz2'
  source_sha256 '8ad26ca717ec3c74e261f454dd6bb316333a39fd1f87db4ac44706a860dc4d28'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.56-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.56-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.56-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.56-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '42a003545e08b7a59cfeaad87600d5144935e3b2ba7adeb18477ba9b30c50d4c',
     armv7l: '42a003545e08b7a59cfeaad87600d5144935e3b2ba7adeb18477ba9b30c50d4c',
       i686: '8fe7d7375039a79441f0d4b365cfdd6391bb8bea12ec40d7ece2a8274c437b54',
     x86_64: '70b20df01d205cb2bb3209321b15336f3d1d4917ce784d5826610cc775d8c523',
  })

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}", "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
