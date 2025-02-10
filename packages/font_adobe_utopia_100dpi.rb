require 'buildsystems/autotools'

class Font_adobe_utopia_100dpi < Autotools
  description '100dpi Adobe Utopia PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-100dpi'
  version '1.0.5'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-100dpi.git'
  git_hashtag "font-adobe-utopia-100dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ed64ca48c4de2e80a7ed0c900f47ffa52e16d10fdbd3e607bc0b57bd07f2bd5',
     armv7l: '6ed64ca48c4de2e80a7ed0c900f47ffa52e16d10fdbd3e607bc0b57bd07f2bd5',
     x86_64: 'aaac37b2a6d415ad2d3a532c54fcb4f1d3958475da8cbc39e14a1f166a3d076d'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
