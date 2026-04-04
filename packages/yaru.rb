require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '25.10.3-0ubuntu1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45c8b81223bd1baea33eaa01fcd01bdfed0cb01e2d0081d7d7d0b3518a306a7a',
     armv7l: '45c8b81223bd1baea33eaa01fcd01bdfed0cb01e2d0081d7d7d0b3518a306a7a',
     x86_64: '726b411019f3369b5fe9e6fcd0b43ce1fea0e0da30a428cea9d845c28f646bf7'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
