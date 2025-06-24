require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.114'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gimp.org/pub/babl/#{version.rpartition('.')[0]}/babl-#{version}.tar.xz"
  source_sha256 'bcbb7786c1e447703db3bc7fa34d62d0d2d117b22f04d8834c7b2d5ded456487'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f33c875a253aedc8efac256fe5b3e47921a9a8ab64134b5873678cb92914165',
     armv7l: '4f33c875a253aedc8efac256fe5b3e47921a9a8ab64134b5873678cb92914165',
     x86_64: '11243878e0f34458bf0379a5dcf1e4042d31b6b398bed14baa01f288f7567ddd'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' # R
  depends_on 'pango' => :build

  meson_options '-Denable-gir=true -Denable-vapi=false'

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
