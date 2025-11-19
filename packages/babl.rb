require 'buildsystems/meson'

class Babl < Meson
  description 'babl is a dynamic, any to any, pixel format translation library.'
  homepage 'https://gegl.org/babl/'
  version '0.1.116-1'
  license 'LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/babl.git'
  git_hashtag "BABL_#{version.split('-').first.gsub('.', '_')}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a40314917fe5e723ce54417171c5adcaccfba9dad22803b5e1cfcddeb2d05bf9',
     armv7l: 'a40314917fe5e723ce54417171c5adcaccfba9dad22803b5e1cfcddeb2d05bf9',
     x86_64: 'c3ba6c060a80b7982b6b1617710fd3b3905b166b339d6a6397d9c6bea4018036'
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
