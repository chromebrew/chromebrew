require 'buildsystems/meson'

class Mm_common < Meson
  description 'Common build files of the C++ bindings'
  homepage 'https://www.gtkmm.org/'
  version '1.0.7'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.gnome.org/GNOME/mm-common.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49fba10ad9d9b472750d39ff8aa683eaa3b894456a5aa3ad7c4c2b34f3805022',
     armv7l: '49fba10ad9d9b472750d39ff8aa683eaa3b894456a5aa3ad7c4c2b34f3805022',
     x86_64: '63781beb5e9ad323c5efe0450885b35360e95d2f7d5f4efa32a8b9637784da74'
  })

  gnome

  meson_options '-Duse-network=true'
end
