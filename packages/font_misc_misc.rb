require 'buildsystems/autotools'

class Font_misc_misc < Autotools
  description 'Standard X11 fixed PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/misc-misc'
  version '1.1.3'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/misc-misc.git'
  git_hashtag "font-misc-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2107978ea234f221e206115192686ccb0c089094636c700eca726ebbf48fe9f5',
     armv7l: '2107978ea234f221e206115192686ccb0c089094636c700eca726ebbf48fe9f5',
     x86_64: '81210393e7ab2854079582a35884b29a7f0b91c4b1c4a025bf26087279216786'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
