require 'buildsystems/meson'

class Glibmm_2_68 < Meson
  description 'C++ bindings for GLib api version 2.68'
  homepage 'https://www.gtkmm.org'
  version '2.78.1'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glibmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5555ac0644dc4f44b8274d043a0570bee91ebf66a1876b15929aa70ac80f6638',
     armv7l: '5555ac0644dc4f44b8274d043a0570bee91ebf66a1876b15929aa70ac80f6638',
     x86_64: 'ae75d777e3f5421db84617bf29bb04dc86583d64a292c991dff3ef7fe7ed44ad'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build

  meson_options '-Dbuild-documentation=false'
end
