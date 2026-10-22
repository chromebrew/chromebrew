require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  version '2.49'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f95bec2d7c628a9ce767e2a29204ed2c8f1c6d59f9bdf34917fe87f888b60b8',
     armv7l: '3f95bec2d7c628a9ce767e2a29204ed2c8f1c6d59f9bdf34917fe87f888b60b8',
     x86_64: '46f35e09fd103c8f85d3784a3289646cfb0136cf5d88071eb2d5aba7cdec6f84'
  })

  depends_on 'libx11' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pytest' => :build
end
