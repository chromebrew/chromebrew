require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.72'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.72.tar.xz'
  source_sha256 '64e111097b1fa22f6c9bf044e341a9cd9ee1372c5acfa0b452e7a86fb37c6a42'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.72-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.72-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.72-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.72-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b5f6bf3713b17b58b84317a85baacce34cea32a5346fa806f6c1f2bc656c8a14',
     armv7l: 'b5f6bf3713b17b58b84317a85baacce34cea32a5346fa806f6c1f2bc656c8a14',
       i686: '9a592e9426283d29c9412535cf7f0c23a1dcfac162b2c50895212f8a28933b2a',
     x86_64: 'ad2e2de168723061552dcaaa3ec3f139ef4d77c36b2f28708c192f8683baea85',
  })

  depends_on 'meson' => :build
  depends_on 'lcms'
  depends_on 'pango'
  
  def self.build
    system 'meson',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '_build'
    system 'ninja -v -C _build'
  end
  
  def self.check
    system 'ninja -C _build test'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
