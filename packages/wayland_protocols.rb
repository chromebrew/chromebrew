require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.42'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae8cb199bdefee16b626790e9a5de8d356799698f98252a250e4d2c87d1ff095',
     armv7l: 'ae8cb199bdefee16b626790e9a5de8d356799698f98252a250e4d2c87d1ff095',
       i686: '3a49071ea3ef60da7d32b21e76c0294015343c6f949565d5a557b7197d63fcdb',
     x86_64: '59f739923fedf7316e57c62f4aa4d9e6976da3d141dce79c4d57c0fddbee8730'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
