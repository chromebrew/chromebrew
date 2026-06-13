require 'buildsystems/meson'

class Yaru < Meson
  description 'Yaru default ubuntu theme'
  homepage 'https://github.com/ubuntu/yaru'
  version '26.10.1'
  license 'GPL-3 and CC-BY-SA-4.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/ubuntu/yaru.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '07fa9302eb0b47aa6c7b42e479aee82765a286cee008cde80685acc16e696428',
     armv7l: '07fa9302eb0b47aa6c7b42e479aee82765a286cee008cde80685acc16e696428',
     x86_64: 'e3a51c31a6fbd9fa9d88182892cdf9cb767504cc2e281c324fe21a513b60f89f'
  })

  depends_on 'sassc'

  meson_options ' -Dubuntu-unity=true'
end
