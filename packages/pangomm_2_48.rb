require 'buildsystems/meson'

class Pangomm_2_48 < Meson
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.54.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ff2f55f43473c0aec6d1db73851891f5571118bb18b498fbaa397c6d161f22',
     armv7l: 'b3ff2f55f43473c0aec6d1db73851891f5571118bb18b498fbaa397c6d161f22',
     x86_64: '83d5f2ee8c710d70044a96199c835e76815c97112413e81ab24fa331bc4a49ec'
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

  gnome

  meson_options '-Dmaintainer-mode=true \
    -Dbuild-documentation=false'
end
