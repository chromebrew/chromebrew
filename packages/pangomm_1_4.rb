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
    aarch64: 'a86e0c8cc640c6d88c3557811255be336ec992a905a23540cec1ae8650f7a1a0',
     armv7l: 'a86e0c8cc640c6d88c3557811255be336ec992a905a23540cec1ae8650f7a1a0',
     x86_64: 'b0690d1ad21732cd2af6a6cf298a8ad28bb127c7c43a75a9a5deca24b17b138d'
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
