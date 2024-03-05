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
    aarch64: 'd101b082fdbd28e16fed1ad66a3042a58f4d4d5575e5a5b9de59552ac8402964',
     armv7l: 'd101b082fdbd28e16fed1ad66a3042a58f4d4d5575e5a5b9de59552ac8402964',
     x86_64: '115a613e6a6f7dcc3faa0f4bbc5eecadb068951a3c9e1bf0a9f90102702db5a0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'graphviz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'mm_common' => :build

  meson_options '-Dbuild-documentation=false'
end
