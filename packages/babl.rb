require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.74'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.74.tar.xz'
  source_sha256 '9a710b6950da37ada94cd9e2046cbce26de12473da32a7b79b7d1432fc66ce0e'

  binary_url ({
  })
  binary_sha256 ({
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
