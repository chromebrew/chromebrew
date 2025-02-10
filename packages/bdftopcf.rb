require 'buildsystems/autotools'

class Bdftopcf < Autotools
  description 'BDF to PCF font converter for X11'
  homepage 'https://gitlab.freedesktop.org/xorg/util/bdftopcf'
  version '1.1.1'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/util/bdftopcf.git'
  git_hashtag "bdftopcf-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b88d5ea3528d5134b6eceb5181c7808a4556693d5ed0f54451d8fd06eff77aeb',
     armv7l: 'b88d5ea3528d5134b6eceb5181c7808a4556693d5ed0f54451d8fd06eff77aeb',
     x86_64: '33f241e6bc50687b20e605fabef914dc2b3f60678786f58a371331ec30048319'
  })

  depends_on 'libxfont'
  depends_on 'xorg_macros' => :build
end
