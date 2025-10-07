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
    aarch64: 'be7287111f3bc930bb5c90e17e9f780370cbdce03116d101d6ca281000fbcf78',
     armv7l: 'be7287111f3bc930bb5c90e17e9f780370cbdce03116d101d6ca281000fbcf78',
     x86_64: 'e0c2c516e7ff9fdff3c10f4930497e3e187cbee0fe34ffd618e0a98f8a91abe2'
  })

  depends_on 'fop' => :build
  depends_on 'libxtrans' => :build
  depends_on 'libfontenc' => :build
  depends_on 'libx11' => :build
  depends_on 'harfbuzz' => :build
  depends_on 'xmlto' => :build
end
