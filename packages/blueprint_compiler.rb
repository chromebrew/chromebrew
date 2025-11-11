# Adapted from Arch Linux blueprint-compiler PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/blueprint-compiler/trunk/PKGBUILD

require 'buildsystems/meson'

class Blueprint_compiler < Meson
  description 'A markup language for GTK user interfaces'
  homepage 'https://jwestman.pages.gitlab.gnome.org/blueprint-compiler/'
  version '0.8.1'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/jwestman/blueprint-compiler.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f9436296b3b3cc53ed1307e21493754054037fa4ee69e8d047316d7d9906ce07',
     armv7l: 'f9436296b3b3cc53ed1307e21493754054037fa4ee69e8d047316d7d9906ce07',
       i686: '3d3d35a011256158f200ea5761ac3562f534733865a03c6f1023284e79235bca',
     x86_64: 'aea9ec478d565bb9b240157630ae265e11f108652293131b439c8bf43ed546b9'
  })

  depends_on 'py3_pygobject' => :build
end
