require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.45'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fee2ab27728f5b81089c5e3ad70ee4b86e8cf5d64fc947b1c6b6234a695a0960',
     armv7l: 'fee2ab27728f5b81089c5e3ad70ee4b86e8cf5d64fc947b1c6b6234a695a0960',
       i686: '3a49071ea3ef60da7d32b21e76c0294015343c6f949565d5a557b7197d63fcdb',
     x86_64: '16f6900f0dd3aa9e38c577ad221e3d58c7713a111cfcd1348c3466b7d5822104'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
