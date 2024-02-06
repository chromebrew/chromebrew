require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.3.1'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b11b612eafd93e0f618cde4d29533e8d03d5b452aec21edd38324c5ad607721c',
     armv7l: 'b11b612eafd93e0f618cde4d29533e8d03d5b452aec21edd38324c5ad607721c',
       i686: '277ae382e6e7e52f7862d5e8d43d9577ac4bb51d850f2ef602f718a9ffddd91a',
     x86_64: '318d8de75fe29afd7119b2e6fffc613f53093b1bc5bee0d55ec38a634e504ac6'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
