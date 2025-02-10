require 'buildsystems/autotools'

class Font_dec_misc < Autotools
  description 'DEC cursor and session PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/dec-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/dec-misc.git'
  git_hashtag "font-dec-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b9f79ae1a17d7efaeecb5261cd13f682d5507ad9b2a813bfb4c314fec984adcf',
     armv7l: 'b9f79ae1a17d7efaeecb5261cd13f682d5507ad9b2a813bfb4c314fec984adcf',
     x86_64: 'a72e3d86dff1bc000325e2ee4b82aaccc20c1c06aa59f8c35144211e23f7ae91'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
