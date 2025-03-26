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
    aarch64: '3433445fdbd0c9f02042499e32c81938212bb5eee99bfc528d9324940c9693c1',
     armv7l: '3433445fdbd0c9f02042499e32c81938212bb5eee99bfc528d9324940c9693c1',
       i686: '3a49071ea3ef60da7d32b21e76c0294015343c6f949565d5a557b7197d63fcdb',
     x86_64: '59f739923fedf7316e57c62f4aa4d9e6976da3d141dce79c4d57c0fddbee8730'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
