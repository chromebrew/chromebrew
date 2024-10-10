require 'buildsystems/autotools'

class Font_bh_100dpi < Autotools
  description 'Standard 100dpi Bigelow and Holmes PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-100dpi'
  version '1.0.4'
  license 'public-domain'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-100dpi.git'
  git_hashtag "font-bh-100dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a09cdb7ce9a722326e0d50ddfb697e98f5fd01576495a490b8ccee3e30142653',
     armv7l: 'a09cdb7ce9a722326e0d50ddfb697e98f5fd01576495a490b8ccee3e30142653',
     x86_64: '451f2aa46eb981d5753a803dcd918a6c47930316a918385de907977ccbc47c7a'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
