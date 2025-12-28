require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.118'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/babl.git'
  git_hashtag "BABL_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e9c98331062a69a27225181df361fc9094457b104566eb6ccadc124ac8f836f6',
     armv7l: 'e9c98331062a69a27225181df361fc9094457b104566eb6ccadc124ac8f836f6',
     x86_64: 'b51feabbec06c9ed1c6734fd788c61682b0d614bb26c9caf6b1b6ac8393de312'
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
