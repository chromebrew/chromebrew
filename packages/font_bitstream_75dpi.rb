require 'buildsystems/autotools'

class Font_bitstream_75dpi < Autotools
  description 'Standard 75dpi Bitstream PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bitstream-75dpi'
  version '1.0.4'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bitstream-75dpi.git'
  git_hashtag "font-bitstream-75dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '890f29742ae3607ba95a89568a5bea6710bbfd4dc6551c32b82af3884d1f5892',
     armv7l: '890f29742ae3607ba95a89568a5bea6710bbfd4dc6551c32b82af3884d1f5892',
     x86_64: '33d485dcf56154e69a2d55cc06309f1550d42f7f3ddf1012f6230744ae6a8d18'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
