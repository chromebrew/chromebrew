require 'buildsystems/meson'

class Atkmm16 < Meson
  description 'Atkmm is the official C++ interface for the ATK accessibility toolkit library.'
  homepage 'https://www.gtkmm.org/'
  version '2.28.3'
  license 'LGPL-2.1+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/atkmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f6bdd8bceb5b59604f8fc5ecff550c67ce2c05ead5a631ff0c08f1bca49a756',
     armv7l: '6f6bdd8bceb5b59604f8fc5ecff550c67ce2c05ead5a631ff0c08f1bca49a756',
     x86_64: 'c8330f03414564ade76af89936973b7667cf4a1c56ff2f5ae61024b4e1d3d731'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glibmm_2_4' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus' # R

  gnome
  no_upstream_update

  meson_options '-Dbuild-documentation=false'
end
