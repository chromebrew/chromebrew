require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '27.04.0'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2824909cac8f51b71468ce738092d31c488af9d4b998a45b36ae707e6a0892a6',
     armv7l: '2824909cac8f51b71468ce738092d31c488af9d4b998a45b36ae707e6a0892a6',
     x86_64: '7282fe94c472420292b0b7d3134db7426cb72d272c2656866310b6042d70de91'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
