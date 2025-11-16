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
    aarch64: '0986b9e40794045e27836213da379a2dafcd49dc4edcd7f8e52ab5664005fba5',
     armv7l: '0986b9e40794045e27836213da379a2dafcd49dc4edcd7f8e52ab5664005fba5',
     x86_64: 'a7d4a6e0ef80baf2475cd34f29f124f6fbaabcc6b2be83316261034e1ec8989e'
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
