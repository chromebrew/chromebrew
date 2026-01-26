require 'buildsystems/meson'

class Libxkbcommon < Meson
  description 'Keymap handling library for toolkits and window systems'
  homepage 'https://xkbcommon.org'
  version '1.13.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/xkbcommon/libxkbcommon.git'
  git_hashtag "xkbcommon-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f47b5809d6c349db50d6e357348fdb473975485e8bf1eb7c2c2a798a97a08045',
     armv7l: 'f47b5809d6c349db50d6e357348fdb473975485e8bf1eb7c2c2a798a97a08045',
     x86_64: 'a5c98021c1eb33bc8f15794d95eec8c50d7eaf6ff3ec4aa7110b61d5b630507b'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' # R
  depends_on 'libxml2' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'
end
