require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.72'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.72.tar.xz'
  source_sha256 '64e111097b1fa22f6c9bf044e341a9cd9ee1372c5acfa0b452e7a86fb37c6a42'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson' => :build
  
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
