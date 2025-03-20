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
    aarch64: '4f33c875a253aedc8efac256fe5b3e47921a9a8ab64134b5873678cb92914165',
     armv7l: '4f33c875a253aedc8efac256fe5b3e47921a9a8ab64134b5873678cb92914165',
     x86_64: 'cbd2b22313489ad73e0d37762fc55344b26711300088685597403d70c53ac13d'
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
