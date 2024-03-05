require 'buildsystems/meson'

class Pangomm_1_4 < Meson
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.46.4'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aebb5450624f733edb35c4397445b2992996f29820e9d13880ce348ad38d1498',
     armv7l: 'aebb5450624f733edb35c4397445b2992996f29820e9d13880ce348ad38d1498',
     x86_64: 'bbad260e15756dcbb0f0faa65de5c95a3ab00ee8a41481d348db19cb842fe6ab'
  })

  depends_on 'cairomm_1_0' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'graphite' => :build
  depends_on 'libsigcplusplus' # R
  depends_on 'mm_common' => :build
  depends_on 'pango' # R

  meson_options '-Dbuild-documentation=false'
end
