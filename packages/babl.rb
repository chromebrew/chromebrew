require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.116'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://download.gimp.org/pub/babl/#{version.rpartition('.')[0]}/babl-#{version}.tar.xz"
  source_sha256 '50fae069867c7ade1259888ff1e3db85fec86d708252e5385b5a4f39a78ec483'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75f2dd70c49e5afedd3d7aca4557151ad461bc5b256986102af716983a66540f',
     armv7l: '75f2dd70c49e5afedd3d7aca4557151ad461bc5b256986102af716983a66540f',
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
