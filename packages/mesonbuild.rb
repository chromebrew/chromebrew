require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.3.2'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ebb3550b0f8c6a61c9488b61c8ab88b49ee47bac39fce25c9a633dc55829487',
     armv7l: '7ebb3550b0f8c6a61c9488b61c8ab88b49ee47bac39fce25c9a633dc55829487',
       i686: '64faf2b00229c12da3155cb1bad698a6cdcb5a62f8bdec964a7eae853f3eaded',
     x86_64: '677ef7b32c9e7bf020c4038f83edd23e23df9dae2058ad53ac8a460b77052be2'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
