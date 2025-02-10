require 'buildsystems/autotools'

class Font_bitstream_100dpi < Autotools
  description 'Standard 100dpi Bitstream PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bitstream-100dpi'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bitstream-100dpi.git'
  git_hashtag "font-bitstream-100dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c0a64f92d6ad7b796c9a7110fb1f6df5d4455d36d365a46cecc3793608ce4a8',
     armv7l: '7c0a64f92d6ad7b796c9a7110fb1f6df5d4455d36d365a46cecc3793608ce4a8',
     x86_64: 'f4a18537118ee0431cb57eae41c3f3b66ab4389d619d84564a89de3302913cf0'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
