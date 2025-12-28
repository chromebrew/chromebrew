require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.47'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c08a005eb388f860b004fda816fa1726b54e8faff451fa2b5a765cd08af9dcff',
     armv7l: 'c08a005eb388f860b004fda816fa1726b54e8faff451fa2b5a765cd08af9dcff',
       i686: '5aef9699f9584c077c422863381a03692f3e8a24939746d5401ef4851fe10dbb',
     x86_64: '21c5a4dca6484e25bd7c996b52ad468e93a3812c3d8541f6f74281580fd72e9d'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
