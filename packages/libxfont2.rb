require 'buildsystems/autotools'

class Libxfont2 < Autotools
  description 'X.org X font library'
  homepage 'https://www.x.org/wiki/'
  version '2.0.7'
  license 'MIT'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libxfont.git'
  git_hashtag "libXfont2-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ab1e630f1c5a7a5917620dfb5bd34feeea7fdc002f73166d2ef8ed7674a1c537',
     armv7l: 'ab1e630f1c5a7a5917620dfb5bd34feeea7fdc002f73166d2ef8ed7674a1c537',
     x86_64: '4a72ab2f2da91acfff1ff03d0b7c47ac37ad9d0d3c5adc1d6ad1e98448f24200'
  })

  depends_on 'fop' => :build
  depends_on 'libxtrans' => :build
  depends_on 'libfontenc' => :build
  depends_on 'libx11' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'xmlto' => :build
end
