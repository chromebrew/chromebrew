require 'buildsystems/meson'

class Pangomm_2_48 < Meson
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.50.2'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '687e1ed522d7e9a5b1c57ace6367f750809deda529df3e6b563d8671a20847e5',
     armv7l: '687e1ed522d7e9a5b1c57ace6367f750809deda529df3e6b563d8671a20847e5',
     x86_64: 'de91d82689ed64fd86b08a79af6e8e3adadc2815f67646899247c58ca4c0d45d'
  })

  depends_on 'cairomm_1_16' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_68' # R
  depends_on 'glib' # R
  depends_on 'graphite' => :build
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build
  depends_on 'pango' # R

  meson_options '-Dmaintainer-mode=true \
    -Dbuild-documentation=false'
end
