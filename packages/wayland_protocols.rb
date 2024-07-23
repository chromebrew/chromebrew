require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.36'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
       i686: 'a2a0b604dc5d561f4a4707a7917141ab5495eccbaf6551d210609869523978aa',
    aarch64: '2deac94ce13d674e267185959a0b05e1dd478a08ac0b3af6d01df739ec085924',
     armv7l: '2deac94ce13d674e267185959a0b05e1dd478a08ac0b3af6d01df739ec085924',
     x86_64: 'e4e76a920bb7ba97f065e82a0ec3237d405db18614b48ec16c8489b4e831e943'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
