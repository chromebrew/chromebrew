require 'buildsystems/autotools'

class Font_bh_type1 < Autotools
  description 'Standard Bigelow and Holmes Type1 fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-type1'
  version '1.0.4'
  license 'bh-luxi'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-type1.git'
  git_hashtag "font-bh-type1-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b43f24cf1c086a6cdff2727ae5d73cea0d78be984e801d146952b5566a67435',
     armv7l: '5b43f24cf1c086a6cdff2727ae5d73cea0d78be984e801d146952b5566a67435',
     x86_64: 'b2f4d04bb546f485e9f2cdbb740df746ef5873b33c2bdc7ea07c9fbe1fe9b208'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
