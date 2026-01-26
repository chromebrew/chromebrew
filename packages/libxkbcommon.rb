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
    aarch64: '7082a5b8af1d778a40ffd9e346602c39b6c66136dbbc9bd7be5c7cdd9fd81c8e',
     armv7l: '7082a5b8af1d778a40ffd9e346602c39b6c66136dbbc9bd7be5c7cdd9fd81c8e',
     x86_64: '4e3d6544efb95dfd8b6689f5f566150a95c04c4649eb61c271edf66707ea5e49'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' # R
  depends_on 'libxml2' # R
  depends_on 'wayland' # R
  depends_on 'wayland_protocols'
  depends_on 'xkeyboard_config'
end
