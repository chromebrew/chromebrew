require 'buildsystems/autotools'

class Font_cursor_misc < Autotools
  description 'Standard X11 cursors in PCF format'
  homepage 'https://gitlab.freedesktop.org/xorg/font/cursor-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/cursor-misc.git'
  git_hashtag "font-cursor-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5c5e2023983cd3c21d75511dd30bcda491fa174c796fd17b1b5a58b2a4914994',
     armv7l: '5c5e2023983cd3c21d75511dd30bcda491fa174c796fd17b1b5a58b2a4914994',
     x86_64: 'e4c8604bb0aa826a4d4c8333a72880237e96f63efcc3a1f105fe513a712bd649'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
