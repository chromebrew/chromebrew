require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.126'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/babl.git'
  git_hashtag "BABL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4c0885d39b78b5b2bf88779ad06d159e37f9c9c29d00853cbef4f2f52367fc88',
     armv7l: '4c0885d39b78b5b2bf88779ad06d159e37f9c9c29d00853cbef4f2f52367fc88',
     x86_64: 'e833f6b9d2b4d71a8649bbf1492573fc0ce0d085622fa48e2a44afc7a4b4ff19'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' => :library
  depends_on 'pango' => :build
  depends_on 'vala' => :build

  meson_options '-Denable-gir=true'

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
