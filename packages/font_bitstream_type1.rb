require 'buildsystems/autotools'

class Font_bitstream_type1 < Autotools
  description 'Standard Type1 Bitstream PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bitstream-type1'
  version '1.0.4'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bitstream-type1.git'
  git_hashtag "font-bitstream-type1-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6b810f366388122a659b115b8b04fe71bf9695ee6677148dfdec9e0e26c63d5',
     armv7l: 'd6b810f366388122a659b115b8b04fe71bf9695ee6677148dfdec9e0e26c63d5',
     x86_64: '961bd01a0be8a44a121c433b9398be56637c1e1685096ac30d880140ec484fc8'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
