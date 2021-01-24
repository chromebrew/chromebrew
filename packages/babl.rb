require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.74'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.74.tar.xz'
  source_sha256 '9a710b6950da37ada94cd9e2046cbce26de12473da32a7b79b7d1432fc66ce0e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.74-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.74-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.74-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/babl-0.1.74-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '319993fa7f4b0894f58234c3d840c2659ca3f682184a2475f2103043be99152b',
     armv7l: '319993fa7f4b0894f58234c3d840c2659ca3f682184a2475f2103043be99152b',
       i686: '74452a7d6df248030c52677af9dded5d015719a8df074e32c957671126798141',
     x86_64: '5ca99064abc0954b593f43b820a572b138b0828949e4169dcb69ce7c91b016e3',
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
