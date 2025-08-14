require 'buildsystems/autotools'

class Xorg_macros < Autotools
  description 'GNU autoconf macros shared across X.Org projects'
  homepage 'https://gitlab.freedesktop.org/xorg/util/macros'
  version '1.20.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/util/macros.git'
  git_hashtag "util-macros-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ffee12a13ba43fe78dad8720d3061f6bb21244ac8787f4dc82f048e2c63a5778',
     armv7l: 'ffee12a13ba43fe78dad8720d3061f6bb21244ac8787f4dc82f048e2c63a5778',
       i686: '04833b48b1f3197fe86cf1b703d283ebe127369624ce3a5f8890977b464c6356',
     x86_64: '77ddabfa8f45f2ba684fdeb1cf0b9e8183207a2f9d3f7ce958f3064b57e7e747'
  })
end
