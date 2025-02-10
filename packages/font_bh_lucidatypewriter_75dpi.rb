require 'buildsystems/autotools'

class Font_bh_lucidatypewriter_75dpi < Autotools
  description '75dpi Bigelow and Holmes Lucida Typewriter PCF fonts'
  homepage 'https://gitlab.freedesktop.org/xorg/font/bh-lucidatypewriter-75dpi'
  version '1.0.4'
  license 'public-domain'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/font/bh-lucidatypewriter-75dpi.git'
  git_hashtag "font-bh-lucidatypewriter-75dpi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b37fe3f9edb68df783f4397bb3a194a10a069177915032dac01aeb62161ba451',
     armv7l: 'b37fe3f9edb68df783f4397bb3a194a10a069177915032dac01aeb62161ba451',
     x86_64: '4a0a871d1baf437c4d5133e11f8625034caa80fcf1e14f22e41d25f8a510436f'
  })

  depends_on 'bdftopcf'
  depends_on 'font_util'
  depends_on 'mkfontscale'
  depends_on 'xorg_macros' => :build
end
