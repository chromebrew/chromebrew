require 'buildsystems/autotools'

class Font_isas_misc < Autotools
  description '72dpi PCF versions of the Chinese Song Ti fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/isas-misc'
  version '1.0.4'
  license 'custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/isas-misc.git'
  git_hashtag "font-isas-misc-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f853fe754a8eecad25c634cc6e79f01bc7f262a2fe2b6b2f1478da42ff50f22d',
     armv7l: 'f853fe754a8eecad25c634cc6e79f01bc7f262a2fe2b6b2f1478da42ff50f22d',
     x86_64: '52b63203c3f199b7cab057b3fc8b674cf3a2fd80244f8dbd9a9a699385174838'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
