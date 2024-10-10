require 'buildsystems/autotools'

class Font_adobe_75dpi < Autotools
  description 'Standard 75pi Adobe PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/adobe-75dpi'
  version '1.0.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/adobe-75dpi.git'
  git_hashtag "font-adobe-75dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1b84cb99effc37186feb201876773ef64f96ad55fbd999f45f3339d8891d9aea',
     armv7l: '1b84cb99effc37186feb201876773ef64f96ad55fbd999f45f3339d8891d9aea',
     x86_64: '6c5b02f92568ef6f10630234b8d09ff30c9f3cb4c991f51642cd8f0ec5cdae95'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
