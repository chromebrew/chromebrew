require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.35'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'efa077d40d08d1d63f9ee617c015fa82ad9505785902e6711eabc5a9c9cb33f1',
     armv7l: 'efa077d40d08d1d63f9ee617c015fa82ad9505785902e6711eabc5a9c9cb33f1',
     x86_64: 'd4cb8740a82798f2fc6e350261402befe96e7382efae253c46c5e1e8ad3a4fc2'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
