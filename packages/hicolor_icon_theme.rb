require 'buildsystems/meson'

class Hicolor_icon_theme < Meson
  description 'Icon-theme contains the standard also references the default icon theme called hicolor.'
  homepage 'https://www.freedesktop.org/wiki/Software/icon-theme/'
  version '0.18'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xdg/default-icon-theme'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3341e27bb5e2ea8c55b573c32bf34ba4e88da50c6cc1d865eb1c2d91232d44e6',
     armv7l: '3341e27bb5e2ea8c55b573c32bf34ba4e88da50c6cc1d865eb1c2d91232d44e6',
       i686: '574db604ef7db3b401e56ce4387e2a488952fcfa308316cc7127f872ee87557c',
     x86_64: 'f0640114582b89e78c5e884e801d512b3a0f484443fdc0157a6f4db289261bae'
  })
end
