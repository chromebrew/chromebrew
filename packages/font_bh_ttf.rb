require 'buildsystems/autotools'

class Font_bh_ttf < Autotools
  description 'Standard Bigelow and Holmes TrueType fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-ttf'
  version '1.0.4'
  license 'bh-luxi'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-ttf.git'
  git_hashtag "font-bh-ttf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4782f6ee51e308549bf33d9a24c4ea835dc64290a88c2aea7f25215c6dc842b0',
     armv7l: '4782f6ee51e308549bf33d9a24c4ea835dc64290a88c2aea7f25215c6dc842b0',
     x86_64: '35a96b54cbd548c336a946024591b8a289841610235d2936bb6143defe3e1f6d'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
