require 'buildsystems/autotools'

class Font_bh_75dpi < Autotools
  description 'Standard 75dpi Bigelow and Holmes PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-75dpi'
  version '1.0.4'
  license 'public-domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-75dpi.git'
  git_hashtag "font-bh-75dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '758a908c051695df1a4786a43bd758899309b8f4ab2d0f18d531e16920ce5894',
     armv7l: '758a908c051695df1a4786a43bd758899309b8f4ab2d0f18d531e16920ce5894',
     x86_64: 'be640dc42f34504facc44f8f484e14e937e99b6855614f4d2583846d6ec1a294'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
