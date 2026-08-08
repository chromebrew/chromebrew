require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.128'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/babl.git'
  git_hashtag "BABL_#{version.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '614a51a82e0ffbdc75664eadbcd3fd13b5650a687b53c077381038044e84ac5b',
     armv7l: '614a51a82e0ffbdc75664eadbcd3fd13b5650a687b53c077381038044e84ac5b',
     x86_64: 'f35d9049e6c4ea94f55e5b5bfdf8890940ef9dcb59dfd0831a19b47fb0f9985a'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gobject_introspection' => :build
  depends_on 'lcms' => :library
  depends_on 'pango' => :build
  depends_on 'vala' => :build

  meson_options '-Denable-gir=true'

  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end
end
