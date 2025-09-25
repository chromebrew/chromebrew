require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '25.10.2-0ubuntu1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff357cc93840fefb79be41c57a069a110d73e3258622a8b7bbc9c8ca390b5927',
     armv7l: 'ff357cc93840fefb79be41c57a069a110d73e3258622a8b7bbc9c8ca390b5927',
     x86_64: '01596e14bdc62bad815c2c1ab8afcaecf8612499a936d2260ea2e7d5c41dea24'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
