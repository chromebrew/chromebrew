require 'buildsystems/autotools'

class Font_daewoo_misc < Autotools
  description 'Daewoo Gothic PCF format'
  homepage 'https://gitlab.freedesktop.org/xorg/font/daewoo-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/daewoo-misc.git'
  git_hashtag "font-daewoo-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6943bff5d56ec5915fccff48c4ba960eb536018f863441d42a194f5b48518fcf',
     armv7l: '6943bff5d56ec5915fccff48c4ba960eb536018f863441d42a194f5b48518fcf',
     x86_64: '1745b68b815fea96114a778c7ff2bb66a98e9010f1176a9667381f594c51fa00'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
