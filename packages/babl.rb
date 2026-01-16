require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.120'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/babl.git'
  git_hashtag "BABL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2e930124ed3e17713859fa9ec7931fcb8cdb899a440975000857a7e4f2c5f2ad',
     armv7l: '2e930124ed3e17713859fa9ec7931fcb8cdb899a440975000857a7e4f2c5f2ad',
     x86_64: '94b27b43d1bf63c4f6cf77302d6aa9d40e315d3f20020d4dbd01cb2801cb7767'
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
