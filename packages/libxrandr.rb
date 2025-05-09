require 'buildsystems/meson'

class Libxrandr < Meson
  description 'X.org X Resize, Rotate and Reflection extension library'
  homepage 'https://xorg.freedesktop.org/wiki/'
  version '1.5.4-8bf72e8'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxrandr.git'
  git_hashtag '8bf72e84e3cf0106532c5c7b8b30154ce48c70e0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '80a924a7fc016e9aa5c7574f6e527932daba5f97402d5b6f819d55967656eccc',
     armv7l: '80a924a7fc016e9aa5c7574f6e527932daba5f97402d5b6f819d55967656eccc',
     x86_64: '51b2e69ce5fc4d73ca59f2edc9d6845a87b2da245a4188ea288e4a3912195bcf'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxext' # R
  depends_on 'libxrender' # R
  depends_on 'xorg_macros' => :build
  depends_on 'xorg_proto' => :build

  run_tests
end
