require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.112'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gimp.org/pub/babl/#{version.rpartition('.')[0]}/babl-#{version}.tar.xz"
  source_sha256 'bf47be7540d6275389f66431ef03064df5376315e243d0bab448c6aa713f5743'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02c0d1ce437f4103821c1a30491b5cf820c4c3368d89c2a2ab807d6d125ca565',
     armv7l: '02c0d1ce437f4103821c1a30491b5cf820c4c3368d89c2a2ab807d6d125ca565',
     x86_64: '7ae82876b4ce15a73652cbb206ac25093d6fe048814327a818361e6e05e4936b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' # R
  depends_on 'pango' => :build
  depends_on 'vala' => :build

  meson_options '-Denable-gir=true'

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
