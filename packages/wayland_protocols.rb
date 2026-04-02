require 'buildsystems/meson'

class Wayland_protocols < Meson
  description 'Wayland is a protocol for a compositor to talk to its clients.'
  homepage 'https://wayland.freedesktop.org/'
  version '1.48'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/wayland/wayland-protocols.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4cdb07ea1787c35a2aeec097b1c652a28134543c2920a7bacaeaff86ab81ec6',
     armv7l: 'a4cdb07ea1787c35a2aeec097b1c652a28134543c2920a7bacaeaff86ab81ec6',
       i686: 'c1f2a878af0f31c914584c0d0fa93839632768bad1bb83ca32413e5db46829de',
     x86_64: '2d0064564245a9a15e4af9d93fc7fd7ac5c9c922f49a43b9a66695131aa5f030'
  })

  depends_on 'wayland' => :logical

  meson_options '-Dtests=false'
end
