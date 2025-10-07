require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  compatibility 'aarch64 armv7l x86_64'
  version '2.46'
  license 'MIT'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7284049786465af562be6d6710ea7828a5231130f734de8018d4aac5d267f6dc',
     armv7l: '7284049786465af562be6d6710ea7828a5231130f734de8018d4aac5d267f6dc',
     x86_64: '89dfab13b5c3dae4fa449fe21c9515904c867dc85b46573007c1988068c46ca4'
  })

  depends_on 'libx11' => :build
end
