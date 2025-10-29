require 'buildsystems/meson'

class Libxkbcommon < Meson
  description 'Keymap handling library for toolkits and window systems'
  homepage 'https://xkbcommon.org'
  version '1.12.2'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/xkbcommon/libxkbcommon.git'
  git_hashtag "xkbcommon-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3645e90b344cdbf0c577b5c325922c1653222963f2b31cf69507c94f2333dc1',
     armv7l: 'f3645e90b344cdbf0c577b5c325922c1653222963f2b31cf69507c94f2333dc1',
     x86_64: '3f4690034770a2ded75329917a95f6f2eccfafe3eb4c80ba90f599c182331141'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' # R
  depends_on 'libxml2' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'
end
