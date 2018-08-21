require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.56'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.56.tar.bz2'
  source_sha256 '8ad26ca717ec3c74e261f454dd6bb316333a39fd1f87db4ac44706a860dc4d28'


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
