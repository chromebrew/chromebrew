require 'buildsystems/autotools'

class Font_adobe_utopia_75dpi < Autotools
  description '75dpi Adobe Utopia PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-75dpi'
  version '1.0.5'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-75dpi.git'
  git_hashtag "font-adobe-utopia-75dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5cbb091d545f527261503754297c04b8b6f82ce98eff656c03c1bd014e91a585',
     armv7l: '5cbb091d545f527261503754297c04b8b6f82ce98eff656c03c1bd014e91a585',
     x86_64: 'de67a6b5a438fd891df1d2c513ef5208d176ddddc8cf9dd77c6e0b5e6730aac3'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
