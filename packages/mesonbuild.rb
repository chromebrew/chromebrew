require 'buildsystems/python'

class Mesonbuild < Python
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.4.0'
  version "#{@_ver}-py3.12"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c76e5c3dee4da6bb1daa90272dec446c47258b2d316c56cd40512cfc06b4bbb4',
     armv7l: 'c76e5c3dee4da6bb1daa90272dec446c47258b2d316c56cd40512cfc06b4bbb4',
       i686: '3910fd452f58223b7c6ae1b0b79bdbb1ecc32bbc6b72d17a48b0420837e3bd5f',
     x86_64: 'd372339a6b267bc4c93068891559a5ce5d9027480f9fce978846d16da7d6c3b6'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
end
