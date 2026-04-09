require 'buildsystems/meson'

class Xkeyboard_config < Meson
  description 'The non-arch keyboard configuration database for X Window.'
  homepage 'https://www.freedesktop.org/wiki/Software/XKeyboardConfig/'
  version '2.47'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xkeyboard-config/xkeyboard-config.git'
  git_hashtag "xkeyboard-config-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2aeac8ebf7840a67cafe259927f81e05658570bc8b8e77a29ffb78215e6b95ea',
     armv7l: '2aeac8ebf7840a67cafe259927f81e05658570bc8b8e77a29ffb78215e6b95ea',
     x86_64: '64c0bf0cefb402f69b5d9b9616e794c49fd25a44ab3fcca571a40f230f84bbfc'
  })

  depends_on 'libx11' => :build
  depends_on 'libxslt' => :build
  depends_on 'py3_pytest' => :build
end
