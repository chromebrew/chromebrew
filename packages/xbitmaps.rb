require 'buildsystems/autotools'

class Xbitmaps < Autotools
  description 'The xbitmaps package contains bitmap images used by multiple applications built in Xorg chapter.'
  homepage 'https://www.x.org/wiki/'
  version '1.1.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/data/bitmaps.git'
  git_hashtag "xbitmaps-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0a13a0a16e121c1d62ead9a064f08ba95239fc1d560296e116525707b654667',
     armv7l: 'b0a13a0a16e121c1d62ead9a064f08ba95239fc1d560296e116525707b654667',
       i686: '7b1d1167e9eb2f328403d601ac8c5528e342f1564378ff1baeb2e4f93fb32c83',
     x86_64: 'd277b2d353dfa8efc9be26faa44a149bb33024cd130bca495c0d9a176ce7c3e2'
  })

  depends_on 'xorg_macros' => :build
end
