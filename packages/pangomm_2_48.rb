require 'buildsystems/meson'

class Pangomm_2_48 < Meson
  description 'pangomm is the official C++ interface for the Pango font layout library.'
  homepage 'https://developer.gnome.org/pangomm/stable/'
  version '2.52.0'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/pangomm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e1335db7e751445a22f73360025a1b1209a97f84624b82337bb47576b4d5cbd',
     armv7l: '4e1335db7e751445a22f73360025a1b1209a97f84624b82337bb47576b4d5cbd',
     x86_64: '7e13562938b068a914ad41b14a10f037b2b1053030b381b6b5901d829fb6f019'
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
