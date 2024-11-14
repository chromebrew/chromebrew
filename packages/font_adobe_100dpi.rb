require 'buildsystems/autotools'

class Font_adobe_100dpi < Autotools
  description 'Standard 100dpi Adobe PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/adobe-100dpi'
  version '1.0.4'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/adobe-100dpi.git'
  git_hashtag "font-adobe-100dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09c39530b6b95d03d21ba092593d785c95c7a9457f697444e44577fd48f9f08f',
     armv7l: '09c39530b6b95d03d21ba092593d785c95c7a9457f697444e44577fd48f9f08f',
     x86_64: '9247d6c60388a9b4485d622f8ccec1c0e8b0dcebccbdfb31ea497946b7babe41'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
