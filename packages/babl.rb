require 'package'

class Babl < Package
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'http://gegl.org/babl/'
  version '0.1.98'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://download.gimp.org/pub/babl/0.1/babl-0.1.98.tar.xz'
  source_sha256 'f3b222f84e462735de63fa9c3651942f2b78fd314c73a22e05ff7c73afd23af1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.98_armv7l/babl-0.1.98-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.98_armv7l/babl-0.1.98-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.98_i686/babl-0.1.98-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/babl/0.1.98_x86_64/babl-0.1.98-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '8283d5242e2993f2031bafa06a1463017ff6296634221d48ef87cf13eb4bbc3e',
     armv7l: '8283d5242e2993f2031bafa06a1463017ff6296634221d48ef87cf13eb4bbc3e',
       i686: 'c3149f4448fe6da6256a16091b008559091efa3004cfedd3f21f5f96f175df90',
     x86_64: '20497755df0c3290e65bc995fd07e2fcd4bd77ba95cf33d341d7814a5cdc7657'
  })

  depends_on 'gobject_introspection' => :build
  depends_on 'lcms'
  depends_on 'pango'
  depends_on 'glibc' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
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
    Dir.chdir("#{CREW_DEST_LIB_PREFIX}/pkgconfig") do
      FileUtils.ln_s 'babl.pc', 'babl-0.1.pc'
    end
  end
end
