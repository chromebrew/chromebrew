require 'buildsystems/meson'

class Xorg_proto < Meson
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2023.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/proto/xorgproto.git'
  git_hashtag "xorgproto-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '135abd63058e542920a2125ff3d12f59f1f15b4e2ffd8051603e1d8d070aaafc',
     armv7l: '135abd63058e542920a2125ff3d12f59f1f15b4e2ffd8051603e1d8d070aaafc',
       i686: '58a8c851b381479f30e6cb24d3a0402d3990791dd823c297ab3de830e35302a5',
     x86_64: '218d61ce750ba8f793e2f924baec49e65bd111fe9519a5b995dfb839f6f85501'
  })
end
