require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.96'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.96.tar.xz'
  source_sha256 '33673fe459a983f411245a49f81fd7f1966af1ea8eca9b095a940c542b8545f6'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.96_armv7l/babl-0.1.96-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.96_armv7l/babl-0.1.96-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.96_i686/babl-0.1.96-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.96_x86_64/babl-0.1.96-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6b65d71f86b224ac122d23aa119b80564671f90e939fb7fb115eb846c72c68cc',
     armv7l: '6b65d71f86b224ac122d23aa119b80564671f90e939fb7fb115eb846c72c68cc',
       i686: '968658467e7d1d60e13fca412edff461a2416c2b33ffd800965b87fe687f281f',
     x86_64: '8bdfd586755b13ab480530bfe8170c4e59ee73eefef798c29cea8a9fd1da30ff'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'lcms'
  depends_on 'pango'
  depends_on 'glibc' # R

  def self.build
    system "meson #{CREW_MESON_OPTIONS} \
      -Denable-gir=true \
      builddir"
    system 'meson configure builddir'
    system 'ninja -C builddir'
  end

  def self.check
    system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
