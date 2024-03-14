require 'buildsystems/meson'

class Glibmm_2_4 < Meson
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  version '2.66.5'
  license 'LGPL-2.1+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.gnome.org/GNOME/glibmm.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e34ada67361ef49fa5ef6849d86864834f24637492360412645a4f556f8b3d0',
     armv7l: '3e34ada67361ef49fa5ef6849d86864834f24637492360412645a4f556f8b3d0',
     x86_64: 'b259f25b53e787d82690c55235c0180c264e7fcdf50d2e2be9aaf0cabf4f9bf5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'libsigcplusplus' # R
  depends_on 'mm_common' => :build

  gnome

  meson_options '-Dbuild-documentation=false'
end
