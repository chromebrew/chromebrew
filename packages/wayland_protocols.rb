require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.41'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae8cb199bdefee16b626790e9a5de8d356799698f98252a250e4d2c87d1ff095',
     armv7l: 'ae8cb199bdefee16b626790e9a5de8d356799698f98252a250e4d2c87d1ff095',
       i686: '65c84d57744e21aa96ac00c9801bb2a91475ce6bc7a02da2499461b37937819c',
     x86_64: '777ee8c04fcc7179137a9a2ac798ba24570f582a8f41c516f41eb9dc2c62703c'
  })

  depends_on 'wayland' # L

  meson_options '-Dtests=false'
end
