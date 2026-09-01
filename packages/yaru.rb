require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '26.10.2'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9137d97da5c93d5991504ffb8ac8035ebbc0844c25cb9faef0f61809fb820335',
     armv7l: '9137d97da5c93d5991504ffb8ac8035ebbc0844c25cb9faef0f61809fb820335',
     x86_64: '26821b5c12de2646899f9deeae7e7e271b84c94a7c1dc806aa66d525fd2dbe07'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
