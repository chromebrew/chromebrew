require 'buildsystems/autotools'

class Font_jis_misc < Autotools
  description '78dpi PCF versions of the Japanese fixed fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/jis-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/jis-misc.git'
  git_hashtag "font-jis-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebac5c751efdd153e70bcde0c1b0cdc6b2000e7c7e1ccfd3d7ab3dbc4295e5a4',
     armv7l: 'ebac5c751efdd153e70bcde0c1b0cdc6b2000e7c7e1ccfd3d7ab3dbc4295e5a4',
     x86_64: 'bf9aa6eaa352599f1add1cfe5ba8ae9f3f76f9554ce0046791de362e148e0e47'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
