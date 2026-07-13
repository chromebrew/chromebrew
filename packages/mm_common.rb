require 'buildsystems/meson'

class Mm_common < Meson
  description 'Common build files of the C++ bindings'
  homepage 'https://www.gtkmm.org/'
  version '1.0.8'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0b9f8fb1f2e82486e24f7522be3590a4758b9c5a8aa596e7f3addad5f225dfad',
     armv7l: '0b9f8fb1f2e82486e24f7522be3590a4758b9c5a8aa596e7f3addad5f225dfad',
     x86_64: 'b1bb4a4ddcc66abb9665d61540f4047e2fc2dd4c6b1b0740d24fff5c497280f0'
  })

  gnome

  meson_options '-Duse-network=true'
end
