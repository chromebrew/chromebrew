require 'buildsystems/autotools'

class Font_adobe_utopia_type1 < Autotools
  description 'Adobe Utopia Type1 fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-type1'
  version '1.0.5'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/adobe-utopia-type1.git'
  git_hashtag "font-adobe-utopia-type1-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22f1ce834a8dff41f9eb3cea29494d511c79cce89acb078f1a1f85c841a659e0',
     armv7l: '22f1ce834a8dff41f9eb3cea29494d511c79cce89acb078f1a1f85c841a659e0',
     x86_64: '8eec4a13c6a41fa43d482d0ec8ac6fa65836782cbb8ce99d1eb3bf5de6e6f3df'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
