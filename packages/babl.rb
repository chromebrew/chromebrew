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
    aarch64: '467461a726ca6245cf4ca64d3fa342945a1dd348b812645da1e753b8b73a9802',
     armv7l: '467461a726ca6245cf4ca64d3fa342945a1dd348b812645da1e753b8b73a9802',
     x86_64: '0fe641a5047d82d956a8f68f1d781c6040be66f67d7dc2cca0727585f279e810'
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
