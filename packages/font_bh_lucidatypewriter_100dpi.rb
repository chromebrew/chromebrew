require 'buildsystems/autotools'

class Font_bh_lucidatypewriter_100dpi < Autotools
  description '100dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-lucidatypewriter-100dpi'
  version '1.0.4'
  license 'public-domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-lucidatypewriter-100dpi.git'
  git_hashtag "font-bh-lucidatypewriter-100dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '248b4fa213a84f792338aa866a004cb6fb3bf94a1634aee42b9f280d31d5eecd',
     armv7l: '248b4fa213a84f792338aa866a004cb6fb3bf94a1634aee42b9f280d31d5eecd',
     x86_64: '6936c7d571844a13e00b551245e6af9c9e93e11cda76da2eb667d3e3fb56f7da'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
