require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.106'
  license 'LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.106.tar.xz'
  source_sha256 'd325135d3304f088c134cc620013acf035de2e5d125a50a2d91054e7377c415f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '17f0af1b2375ea63e73fc5dc0db25ab6a5ff2320fd8f0e590ee930c57c3b2dd6',
     armv7l: '17f0af1b2375ea63e73fc5dc0db25ab6a5ff2320fd8f0e590ee930c57c3b2dd6',
     x86_64: '859d5da6c95a61a32e65509b1af6f825c25aa683a99815469013432808c458d5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' # R
  depends_on 'pango' => :build
  depends_on 'vala' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
      -Denable-gir=true \
      builddir"
    system 'meson configure --no-pager builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
