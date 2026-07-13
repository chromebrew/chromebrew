require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  version '2.48'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7bc18f045634d1816d27dae56221a17538c9bf97fa8d03c1074c4ef516cfc3a7',
     armv7l: '7bc18f045634d1816d27dae56221a17538c9bf97fa8d03c1074c4ef516cfc3a7',
     x86_64: '5fd9a83eee76352462cfe8d0d6b48c282c4b81b5b54b4edf91fc0c7431941b5d'
  })

  depends_on 'libx11' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pytest' => :build
end
