require 'buildsystems/meson'

class Libxkbfile < Meson
  description 'library for the X window system'
  homepage 'https://x.org/wiki/'
  version '1.2.0'
  license 'MIT and custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxkbfile.git'
  git_hashtag "libxkbfile-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '41802a2bd86366a7dc18e8ac84d54b1080aa0fc7a94401d21ac86aa4aedcf887',
     armv7l: '41802a2bd86366a7dc18e8ac84d54b1080aa0fc7a94401d21ac86aa4aedcf887',
     x86_64: '9fcdc600a377dd17cf58adc849cedc5a1f382520193e819aa344a0ab40a45554'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
end
